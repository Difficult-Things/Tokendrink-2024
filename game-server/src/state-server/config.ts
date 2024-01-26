import { State } from '../../../specifications/StateOutput'

// export const STORE = Date.now().toString()
export const STORE = 'development'
export const STATE_UPDATE_RATE = 30 * 1000

interface TimelineConfig {
  START_DURATION: number;
  BUILD_DURATION: number;
  REVEAL_DURATION: number;
  COUNTDOWN_DURATION: number;
  LIFTOFF_DURATION: number;
  DEBRIEF_DURATION: number;
}

const TIMELINE_CONFIG_REAL_TIME: TimelineConfig = {
  START_DURATION: 517,
  BUILD_DURATION: 240,
  REVEAL_DURATION: 65,
  COUNTDOWN_DURATION: 23,
  LIFTOFF_DURATION: 35,
  DEBRIEF_DURATION: 20,
}

const TIMELINE_CONFIG_LINEAR_TIME_DURATION = parseInt(process.env.TIMELINE_PHASE_DURATION || '5')
const TIMELINE_CONFIG_LINEAR_TIME: TimelineConfig = {
  START_DURATION: TIMELINE_CONFIG_LINEAR_TIME_DURATION * 2,
  BUILD_DURATION: TIMELINE_CONFIG_LINEAR_TIME_DURATION * 2,
  REVEAL_DURATION: TIMELINE_CONFIG_LINEAR_TIME_DURATION,
  COUNTDOWN_DURATION: TIMELINE_CONFIG_LINEAR_TIME_DURATION,
  LIFTOFF_DURATION: TIMELINE_CONFIG_LINEAR_TIME_DURATION,
  DEBRIEF_DURATION: TIMELINE_CONFIG_LINEAR_TIME_DURATION,
}
const TIMELINE_CONFIG_FAST: TimelineConfig = {
  ...TIMELINE_CONFIG_REAL_TIME,
  START_DURATION: 10,
  BUILD_DURATION: 30,
}

export const TIMELINE_CONFIG = (mode => {
  switch (mode) {
    case 'linear':
      return TIMELINE_CONFIG_LINEAR_TIME

    case 'fast':
      return TIMELINE_CONFIG_FAST

    case 'default':
    default:
      return TIMELINE_CONFIG_REAL_TIME
  }
})(process.env.TIMELINE_MODE || 'default')

export const TIMELINE_START = (start => {
  switch (start) {
    case 'now':
      return new Date(
        Date.now()
        +
        (TIMELINE_CONFIG.START_DURATION + TIMELINE_CONFIG.BUILD_DURATION + TIMELINE_CONFIG.REVEAL_DURATION + TIMELINE_CONFIG.COUNTDOWN_DURATION) * 1000
      )

    case 'default':
    default:
      return new Date('2022-11-24T17:30:00')
  }
})(process.env.TIMELINE_START || 'default')

export const TIMELINE_LAUNCH_DURATION = 0 + (Object.values(TIMELINE_CONFIG).reduce((sum, s) => sum + s, 0)) * 1000

// GUARD: Check whether the default timeline is accurate
if (!process.env.TIMELINE_MODE || process.env.TIMELINE_MODE === 'default') {
  if (TIMELINE_LAUNCH_DURATION !== 15*60*1000) {
    throw new Error(`Default timeline adds up to ${TIMELINE_LAUNCH_DURATION / 1000} seconds, instead of 900 seconds (15 minutes). This might fuck up your token drink`)
  }
}

export const DEFAULT_GAME_STATE: State = {
  launch: { launch: 1, date: new Date(TIMELINE_START), type: 'regular' },
  phase: 'start',
  launches: [
    { launch:  1, date: new Date(+ TIMELINE_START + 0 * TIMELINE_LAUNCH_DURATION), type: 'regular' },
    { launch:  2, date: new Date(+ TIMELINE_START + 1 * TIMELINE_LAUNCH_DURATION), type: 'regular' },
    { launch:  3, date: new Date(+ TIMELINE_START + 2 * TIMELINE_LAUNCH_DURATION), type: 'regular' },
    { launch:  4, date: new Date(+ TIMELINE_START + 3 * TIMELINE_LAUNCH_DURATION), type: 'regular' },
    { launch:  5, date: new Date(+ TIMELINE_START + 4 * TIMELINE_LAUNCH_DURATION), type: 'regular' },
    { launch:  6, date: new Date(+ TIMELINE_START + 5 * TIMELINE_LAUNCH_DURATION), type: 'regular' },
    { launch:  7, date: new Date(+ TIMELINE_START + 6 * TIMELINE_LAUNCH_DURATION), type: 'regular' },
    { launch:  8, date: new Date(+ TIMELINE_START + 7 * TIMELINE_LAUNCH_DURATION), type: 'regular' },
    { launch:  9, date: new Date(+ TIMELINE_START + 8 * TIMELINE_LAUNCH_DURATION), type: 'regular' },
    { launch: 10, date: new Date(+ TIMELINE_START + 9 * TIMELINE_LAUNCH_DURATION), type: 'final' },
  ],
  rocketLevels: {
    'orange': 1,
    'green': 1,
    'purple': 1,
    'blue': 1,
    'red': 1,
  },
  teamMultipliers: {
    'orange': 1,
    'green': 1,
    'purple': 1,
    'blue': 1,
    'red': 1,
  },
  globalMultiplier: 1,
  sodaMultiplier: 1.2,
  rankingToRocketLevel: [
    [1, 1, 1, 1, 1],
    [2, 2, 1, 1, 1],
    [3, 3, 2, 2, 1],
    [4, 4, 3, 3, 2],
    [5, 5, 4, 4, 3],
    [5, 5, 5, 4, 4],
    [6, 6, 5, 5, 4],
    [7, 7, 6, 6, 5],
    [8, 8, 7, 7, 6],
    [9, 9, 9, 8, 8],
  ],
  totalDrinks: {
    beer: {
      'orange': 0,
      'green': 0,
      'purple': 0,
      'blue': 0,
      'red': 0,
    },
    soda: {
      'orange': 0,
      'green': 0,
      'purple': 0,
      'blue': 0,
      'red': 0,
    },
  },
  scores: {
    'orange': 0,
    'green': 0,
    'purple': 0,
    'blue': 0,
    'red': 0,
  },
  ranking: ['orange', 'green', 'purple', 'blue', 'red'],
  previousRound: {
    scores: {
      'orange': 0,
      'green': 0,
      'purple': 0,
      'blue': 0,
      'red': 0,
    }, 
    totalDrinks: {
      beer: {
        'orange': 0,
        'green': 0,
        'purple': 0,
        'blue': 0,
        'red': 0,
      },
      soda: {
        'orange': 0,
        'green': 0,
        'purple': 0,
        'blue': 0,
        'red': 0,
      },
    },
  },
  oldestMember: {
    name: 'Paul van Beek',
    generation: 2009,
    team: 'green',
  },
}
