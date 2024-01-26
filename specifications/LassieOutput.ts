/** These events will be received on the `/lassie/output` topic */
import { TeamColors } from './Common';

/** The tally of drinks */
export interface LassieState {
    /** The number of beers that were ordered */
    beer: Record<TeamColors, number>;
    /** The number of sodas that were ordered */
    soda: Record<TeamColors, number>;
}

/** An event that specifies the total number of drinks that were drunk since the
 * start of the game */
export interface GlobalLassieEvent {
    name: 'lassieGlobal';
    state: LassieState;
	/** The amount of orders that were placed by a teamcolor that only contain a single drink */
	singleDrinkOrders?: Record<TeamColors, number>;
}

/** An event that specifies the number of drinks that were ordered in a
 * particular time period. */
export interface PeriodLassieEvent {
    name: 'lassiePeriod';
    state: LassieState;
    from: string;
    to: string;
    /** An optional id that could have been specified in the
     * retrieveDrinksForSpecificPeriod event */
    id?: string;
}

/** An event that specifies either per team or per generation how many people
 * have checked in. */
export interface CheckinsLassieEvent {
    name: 'lassieCheckins';
    perColor: Record<TeamColors, number>;
    perGeneration: Record<string, number>;
}

export type LassieOutputEvent = GlobalLassieEvent | PeriodLassieEvent | CheckinsLassieEvent;
