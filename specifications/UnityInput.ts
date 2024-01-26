/** These events should be sent on the `/unity/input` topic */

export interface TriggerEffectEvent {
    name: 'triggerEffect';
    payload: unknown;
}