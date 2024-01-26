/** These events should be sent on the `/state/input` topic */

import { TeamColors } from './Common';
import { LaunchPhase, State } from './StateOutput';

/** Ask the gameserver to send the current game state again */
export interface RetrieveStateEvent {
    name: 'retrieveState'
}

/** Adjust the score for one or more teams */
export interface AdjustScoreEvent {
    name: 'adjustScore';
    payload: {
        delta: number;
        teams: TeamColors[];
    }
}

/** Adjust the score multiplier for individual teams */
export interface AdjustTeamMultiplier {
    name: 'adjustTeamMultiplier';
    payload: {
        teamMultiplier: number;
        teams: TeamColors[];
    }
}

/** Adjust the global score multiplier */
export interface AdjustGlobalMultiplier {
    name: 'adjustGlobalMultiplier';
    payload: {
        globalMultiplier: number;
    }
}

/** Adjust the multiplier for drink types other than beers. Beers will always
 * receive a multiplier of 1   */
export interface AdjustSodaMultiplier {
    name: 'adjustSodaMultiplier';
    payload: {
        sodaMultiplier: number;
    }
}

/** Adjust the current game phase */
export interface SetCurrentPhase {
    name: 'setCurrentPhase';
    payload: {
        phase: LaunchPhase;
    }
}

/** Adjust the current game launch (round number) */
export interface SetCurrentLaunch {
    name: 'setCurrentLaunch';
    payload: {
        launch: number;
    }
}

/** Replace the entire game state with a new value */
export interface SetGameState {
    name: 'setGameState';
    payload: State;
}

export interface SetDefaultGameState {
    name: 'setDefaultGameState';
}

export interface SetRocketMapping {
    name: 'setRocketMapping';
    payload: State['rankingToRocketLevel'];
}

export interface SetOldestMember {
    name: 'setOldestMember';
    payload: State['oldestMember'];
}

export type StateInputEvent = RetrieveStateEvent | AdjustScoreEvent | AdjustTeamMultiplier | AdjustGlobalMultiplier | AdjustSodaMultiplier | SetCurrentLaunch | SetCurrentPhase | SetGameState | SetDefaultGameState | SetRocketMapping | SetOldestMember;