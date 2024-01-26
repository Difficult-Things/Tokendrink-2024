import { TeamColors } from '../../../specifications/Common';
import { GlobalLassieEvent, LassieState } from '../../../specifications/LassieOutput';
import { AdjustScoreEvent, AdjustTeamMultiplier } from '../../../specifications/StateInput';
import { Launch, LaunchPhase, LaunchType, State } from '../../../specifications/StateOutput';
import GameState from './GameState';

export default class GameStateManager {
  state: GameState;

  constructor(state: GameState) {
    this.state = state
  }

  getState() {
   return this.state.get()
  }

  set(state: Partial<State>): void;
  set<K extends keyof State>(key: K, value: State[K]): void;
  set<K extends keyof State>(key: K | Partial<State>, value?: State[K]): void {
    if (value && typeof key ==='string') {
      this.state.set(key, value)
    } else if (typeof key === 'object') {
      this.state.set(key);
    }
  }

  setState(obj: State) {
    Object.entries(obj).map(([key, value]) => this.set(key as keyof State, value))
  }

  setLaunch(launchNumber: number) {
    const launches = this.state.get('launches');
    const launch = launches.find((l) => l.launch === launchNumber);

    if (launch) {
      this.set('launch', launch);
    } else {
      console.error('Could not find launch with number ' + launchNumber);
    }
  }

  setLaunches(launches: Launch[]) {
    this.set('launches', launches)
  }

  setPhase(phase: LaunchPhase) {
    let newState: Partial<State> = {};

    // First, trigger any state updates such as calculating rockets levens
    // and/or calculating the rankings of all teams. We must do this first,
    // because we need this part of the state to be in place when we trigger the
    // phase change, as that is what all connected systems switch on.
    if (phase === 'reveal') {
      Object.assign(newState, this.calculateRocketLevels());
    } else if (phase === 'liftoff' || phase === 'finalLiftoff') {
      Object.assign(newState, this.calculateRanking());
    }

    // Then also inject the phase change and assign it to the state
    Object.assign(newState, { phase });
    this.set(newState);
  }

  setRocketLevel(teamColor: TeamColors, level: number) {
    const rocketLevels = this.state.get('rocketLevels')
    rocketLevels[teamColor] = level
    this.set('rocketLevels', rocketLevels)
  }

  setRocketLevels(mappings: Record<TeamColors, number>) {
    Object.entries(mappings).map(
      ([team, level]) => this.setRocketLevel(team as TeamColors, level)
    )
  }

  calculateRocketLevels(): Partial<State> {
    const { rankingToRocketLevel, scores, launch, rocketLevels } = this.state.get();

    // Get the correct mapping for this particular launch
    const mapping = rankingToRocketLevel[launch.launch - 1];

    // Rank the teams based on their scores
    const ranking = Object.keys(scores).sort((a, b) => {
      return scores[b as TeamColors] - scores[a as TeamColors];
    });

    // Then calculate the rocket levels
    const newRocketLevels = { ...rocketLevels };
    ranking.forEach((team, index) => {
      newRocketLevels[team as TeamColors] = mapping[index];
    });

    // Then assign the rocket levels
    return { rocketLevels: newRocketLevels };
  }

  calculateRanking(): Partial<State> {
    const { scores, totalDrinks } = this.state.get();

    const ranking = Object.keys(scores).sort((a, b) => {
      return scores[b as TeamColors] - scores[a as TeamColors];
    }) as TeamColors[];

    return { ranking, previousRound: { scores, totalDrinks } };
  }

  setScore(payload: AdjustScoreEvent['payload']) {
    const scores = { ...this.state.get('scores') };
    for (let team of payload.teams) {
      if (team in scores) {
        scores[team as TeamColors] += payload.delta;
      }
    }
    this.set('scores', scores)
  }

  setRocketMapping(mapping: number[][]) {
    this.set('rankingToRocketLevel', mapping);
  }

  setTeamMultiplier(team: TeamColors, multiplier: number) {
    const teamMultipliers = this.state.get('teamMultipliers')
    teamMultipliers[team] = multiplier
    this.set('teamMultipliers', teamMultipliers)
  }

  setTeamMultipliers(payload: AdjustTeamMultiplier['payload']) {
    const teamMultipliers = { ...this.state.get('teamMultipliers') };
    for (let team of payload.teams) {
      teamMultipliers[team as TeamColors] = payload.teamMultiplier;
    }
    this.state.set('teamMultipliers', teamMultipliers);
  }

  setSodaMultiplier(multiplier: number) {
    this.set('sodaMultiplier', multiplier)
  }

  setGlobalMultiplier(multiplier: number) {
    this.set('globalMultiplier', multiplier)
  }
  
  handleLassieGlobal(event: GlobalLassieEvent) {
    const {
      totalDrinks, scores, sodaMultiplier, teamMultipliers, globalMultiplier,
    } = this.state.get();

    // Calculate the consumption deltas using the previous totals, as compared 
    // to the incoming Lassie update.
    const deltas = (Object.keys(totalDrinks) as (keyof LassieState)[]).reduce((sum, drinkType) => {
      sum[drinkType] = (Object.keys(totalDrinks[drinkType]) as TeamColors[]).reduce((teamSum, team) => {
        teamSum[team] = event.state[drinkType][team] - totalDrinks[drinkType][team]

        // GUARD: Set delta to 0, in case everything crashes and the lassie bridge needs to replay all transactions.
        if (teamSum[team] < 0) {
          teamSum[team] = 0;
        }

        return teamSum;
      }, {} as LassieState[keyof LassieState]);
      return sum;
    }, {} as LassieState);

    // Assign the new totals to the game state
    this.set('totalDrinks', event.state);

    // Assign new scores using the consumption deltas
    const newScores = {...scores};
    for (let team in scores) {
      // First, calculate all the scores per drink type
      let deltaScore = deltas.beer[team as TeamColors];
      deltaScore += deltas.soda[team as TeamColors] * sodaMultiplier;

      // Then, apply all multipliers
      deltaScore *= teamMultipliers[team as TeamColors];
      deltaScore *= globalMultiplier;

      // Then, assign the new score
      newScores[team as TeamColors] += deltaScore;
    }

    // Also assign the new score
    this.set('scores', newScores);
  }
}
