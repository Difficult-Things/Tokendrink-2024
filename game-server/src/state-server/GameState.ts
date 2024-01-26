import storage from 'node-persist';
import path from 'path';
import EventEmitter from 'events';
import { State } from '../../../specifications/StateOutput';

interface Options {
  persistState: boolean;
  persistLocation: string;
  log: boolean;
}

interface VersionedState extends State {
  _state_version: number;
  _state_last_change: number;
  _state_retrieved?: number;
}

export default class GameState extends EventEmitter {
  opts: Options;
  state: VersionedState;

  constructor(
    opts = {},
    initialState = {}
  ) {
    super();
    const defaultOpts = {
      persistState: true,
      persistLocation: '_data/game_state',
      log: true,
    }
    this.opts = {
      ...defaultOpts,
      ...opts
    }
    // @ts-ignore
    this.state = {
      _state_version: 0,
      _state_last_change: Date.now(),
      ...initialState
    }
  }

  async loadStore(tag = 'default') {
    if (this.opts.persistState !== true) {
      console.error('loadStore called but persistState = false!')
      return false
    }
    try {
      await storage.init({
        dir: path.resolve(this.opts.persistLocation, tag)
      })
      await storage.forEach(({ key, value }) => {
        this.set(key as keyof State, value, false, false)
      })
      if (this.opts.log) {
        console.log(`Loaded ${await storage.length()} keys from store ${tag}: ${await storage.keys()}`)
      }
      return true
    } catch (e) {
      console.error('Could not load/create persistent storage file!', e)
      return false
    }
  }

  get(): VersionedState;
  get<K extends keyof State>(property: K): State[K]
  get(property = undefined): any  {
    if (typeof property === 'string') {
      return this.state[property]
    } 

    return {
      _state_retrieved: Date.now(),
      ...this.state
    }
  }

  set(newState: Partial<State>, value?: null, persist?: boolean, report?: boolean): boolean
  set<K extends keyof State>(key: K, value: State[K], persist?: boolean, report?: boolean): boolean
  set<K extends keyof State>(keyOrNewState: K | Partial<State>, value: State[K] | null, persist = true, report = true): boolean {
    const keys = typeof keyOrNewState === 'object'
      ? Object.keys(keyOrNewState)
      : [keyOrNewState];

    try {
      // @ts-ignore
      if (typeof keyOrNewState === 'object') {
        Object.assign(this.state, keyOrNewState);
      } else if (value !== null) {
        // @ts-ignore
        this.state[keyOrNewState] = value;
      }

      if (report) {
        this.state._state_version++;
        this.state._state_last_change = Date.now()
      }

      if (persist) {
        Promise.resolve([...keys, '_state_version', '_state_last_change'].map(stateKey =>
          // @ts-ignore
          storage.setItem(stateKey, this.state[stateKey])
        ))
      }

    } catch (e) {
      console.error(`Could not set state property '${keys}':`, e)
      return false
    }

    if (this.opts.log) {
      console.log(`State property '${keys}' set to '${value}' with persist = ${persist.toString()}`)
    }

    this.emit('update', this.state);

    return true
  }

}
