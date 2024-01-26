/** These events will be received on the `/state/output` topic */

import { TeamColors } from './Common';
import { LassieState } from './LassieOutput';

/** Whether this is a regular launch, or the final launch, after which the final
 *animation should be started */
export type LaunchType = 'regular' | 'final';

/** These are the various phases in a particular launch */
export type LaunchPhase = 'start' | 'build' | 'reveal' | 'countdown' | 'liftoff' |  'finalLiftoff' | 'debrief';

/** This describes a single launch event, either past or present */
export interface Launch {
    /** A date that describes when exactly the rocket should be launched */
    date: Date;
    /** The number for this launch. This is 1-indexed  */
    launch: number;
    /** The specific type for this launch */
    type: LaunchType
}

/** The State object that is served by the gameserver */
export interface State {
    /** The launch that is associated with the current event */
    launch: Launch;
    /** The current phase in the game */
    phase: LaunchPhase;
    /** The levels for each particular team's rocket, for now defined in 0-10 */
    rocketLevels: Record<TeamColors, number>;
    /** All launches that have been scheduled for this game */
    launches: Launch[];
    /** Score multipliers for individual teams */
    teamMultipliers: Record<TeamColors, number>;
    /** A global multiplier for all scores */
    globalMultiplier: number;
    /** A multiplier for how much a soda is worth as opposed to a beer  */
    sodaMultiplier: number;
    /** This describes which ranking position corresponds to which rocket level
     * in which round. Example: `rankingToRocketLevel[roundNumber][rankingPosition]`  */
    rankingToRocketLevel: number[][];
    /** An ordered array that describes the total accumulated points throughtout
     * the game per team.  */
    scores: Record<TeamColors, number>;
    /** The total number of drinks that have been ordered per generation. */
    totalDrinks: LassieState;
    /** The ranking of all the teams, sorted first to last. This will be updated
     * everytime the phase changes to `liftoff` or `finalLiftoff` */
    ranking: TeamColors[];
    /** This is the data that is locked to the previous round. It will be
     * updated when the phase changes to `liftoff` or `finalLiftoff` */
    previousRound: {
        totalDrinks: LassieState;
        scores: Record<TeamColors, number>;
    },
    /** This should display the oldest member that is a part of a generation.
    *  NOTE: Any staff should be excluded from this metric */
    oldestMember: {
        name: string;
        team: TeamColors;
        generation: number;
    }
}

/** The event that signals the start of a launch */
export interface StartEvent extends State {
    phase: 'start';
}

/** The event that signals a rocket being built */
export interface BuildEvent extends State {
    phase: 'build';
}

/** The event that signals rockets being revealed */
export interface RevealEvent extends State {
    phase: 'reveal';
}

/** The event that signals that we're counting down to liftoff */
export interface CountdownEvent extends State {
    phase: 'countdown';
}

/** The event that signals the rockets being launched */
export interface LaunchEvent extends State {
    phase: 'liftoff';
}

/** The event that signals the rockets being launched for the final time */
export interface FinalLaunchEvent extends Omit<LaunchEvent, 'phase'> {
    phase: 'finalLiftoff';
}

/** The event that signals the rockets being launched for the final time */
export interface DebriefEvent extends State {
    phase: 'debrief';
}

/** A union type for all events  */
export type StateOutputEvent = StartEvent | BuildEvent | RevealEvent | LaunchEvent | FinalLaunchEvent | DebriefEvent;