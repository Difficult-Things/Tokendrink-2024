import { Launch, LaunchPhase } from '../../../specifications/StateOutput'
import { DEFAULT_GAME_STATE, TIMELINE_CONFIG } from '../state-server/config';

export interface TimelineEntry {
  id: string;
  phase: LaunchPhase;
  launch: number;
  timestamp?: Date;
  duration: number;
  offset?: {
    from: string;
    delta: number;
  }
}

export const TIMELINE = DEFAULT_GAME_STATE.launches.flatMap((launch): TimelineEntry[] => {
  const entries: TimelineEntry[] = [
    {
      id: `${launch.launch}-liftoff`,
      launch: launch.launch,
      phase: launch.type === 'regular' ? 'liftoff' : 'finalLiftoff',
      timestamp: launch.date,
      duration: TIMELINE_CONFIG.LIFTOFF_DURATION,
    },
    {
      id: `${launch.launch}-start`,
      launch: launch.launch,
      phase: 'start',
      offset: {
        from: `${launch.launch}-liftoff`,
        delta: -1 * (TIMELINE_CONFIG.START_DURATION + TIMELINE_CONFIG.BUILD_DURATION + TIMELINE_CONFIG.REVEAL_DURATION + TIMELINE_CONFIG.COUNTDOWN_DURATION),
      },
      duration: TIMELINE_CONFIG.START_DURATION,
    },
    {
      id: `${launch.launch}-build`,
      launch: launch.launch,
      phase: 'build',
      offset: {
        from: `${launch.launch}-liftoff`,
        delta: -1 * (TIMELINE_CONFIG.BUILD_DURATION + TIMELINE_CONFIG.REVEAL_DURATION + TIMELINE_CONFIG.COUNTDOWN_DURATION),
      },
      duration: TIMELINE_CONFIG.BUILD_DURATION,
    },
    {
      id: `${launch.launch}-reveal`,
      launch: launch.launch,
      phase: 'reveal',
      offset: {
        from: `${launch.launch}-liftoff`,
        delta: -1 * (TIMELINE_CONFIG.REVEAL_DURATION + TIMELINE_CONFIG.COUNTDOWN_DURATION),
      },
      duration: TIMELINE_CONFIG.REVEAL_DURATION,
    },
    {
      id: `${launch.launch}-countdown`,
      launch: launch.launch,
      phase: 'countdown',
      offset: {
        from: `${launch.launch}-liftoff`,
        delta: -1 * TIMELINE_CONFIG.COUNTDOWN_DURATION,
      },
      duration: TIMELINE_CONFIG.COUNTDOWN_DURATION,
    },
    
  ];

  if (launch.type === 'regular') {
    entries.push({
      
        id: `${launch.launch}-debrief`,
        launch: launch.launch,
        phase: 'debrief',
        offset: {
          from: `${launch.launch}-liftoff`,
          delta: TIMELINE_CONFIG.LIFTOFF_DURATION,
        },
        duration: TIMELINE_CONFIG.DEBRIEF_DURATION,
      
    })
  }

  return entries;
});
