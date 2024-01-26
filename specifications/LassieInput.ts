/** These events should be sent on the `/lassie/input` topic */

/** Retrieve the current tally of drinks */
export interface RetrieveDrinksEvent {
    name: 'retrieveDrinks';
}

/** Retrieve a tally of drinks for a specific period */
export interface RetrieveDrinksForSpecificPeriodEvent {
    name: 'retrieveDrinksForSpecificPeriod';
    payload: {
        start: string;
        end: string;
        /** An optional id that will be included with the result event */
        id?: string;
    }
}

/** Retrieve the check-in numbers from Lassie */
export interface RetrieveCheckinsEvent {
    name: 'retrieveCheckins'
}

/** Union type of all possible Lassie input events */
export type LassieInputEvent = RetrieveDrinksEvent | RetrieveDrinksForSpecificPeriodEvent | RetrieveCheckinsEvent;


