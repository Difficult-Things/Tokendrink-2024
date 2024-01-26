// @ts-nocheck

class TimelineManager {

  constructor(timeline) {
    this.load(timeline)
    this.timeouts = {}
    this.handlers = [
      () => {},
      () => {}
    ]
  }

  load(timeline) {
    this._timeline = timeline
    this.entries = {}
    this.timeouts = {}

    this._timeline.map(entry => this.entries[entry.id] = entry)

    Object.values(this.entries)
      .filter(entry => entry.hasOwnProperty('timestamp'))
      .map(entry => this.entries[entry.id]._computed_timestamp = entry.timestamp)
    
    Object.values(this.entries)
      .filter(entry => entry.hasOwnProperty('offset'))
      .filter(entry => this.entries[entry.offset.from].hasOwnProperty('_computed_timestamp'))
      .map(entry =>
        this.entries[entry.id]._computed_timestamp = new Date(+this.entries[entry.offset.from]._computed_timestamp + entry.offset.delta * 1000)
      )

    Object.values(this.entries)
      .filter(entry => !entry.hasOwnProperty('_computed_timestamp'))
      .filter(entry =>
        this.entries[entry.id]._computed_timestamp = new Date(+this.entries[entry.offset.from]._computed_timestamp + entry.offset.delta * 1000)
      )
    
    const sorted = Object.values(this.entries)
      .sort((a, b) => a._computed_timestamp - b._computed_timestamp)
    sorted
      .map((entry, index) => {
        this.entries[entry.id].order = index
        const prevIndex = Math.max(index - 1, 0)
        this.entries[entry.id]._computed_previous_timestamp_diff = entry._computed_timestamp - sorted[prevIndex]._computed_timestamp
      })
    
    const expireAfter = new Date
    Object.values(this.entries)
      .filter(entry => entry._computed_timestamp < expireAfter)
      .map(entry => this.entries[entry.id].expired = true)
    
  }

  start() {
    const entries = Object.values(this.entries)
      .sort((a, b) => a._computed_timestamp - b._computed_timestamp)
      .filter(e => e._computed_timestamp > new Date())
    
    if (!entries.length) {
      console.error(`SCHEDULER ${(new Date()).toTimeString().slice(0,17)}: No upcoming items to be scheduled!`)
      return
    }
    
    const upcoming = entries.map(e => e.id)
    if (upcoming.length <= 1) upcoming.push('none')
    const entry = entries[0]

    console.log(`SCHEDULER ${(new Date()).toTimeString().slice(0,17)}: Scheduling next event '${entry.id}' at ${entry._computed_timestamp.toTimeString().substr(0,17)} (next: ${upcoming.slice(1).join(', ')})`)
  
    this.timeouts[`${entry.id}__start_timeout`] = setTimeout(() => this.handleStartTimeout(entry), entry._computed_timestamp - new Date)
  }

  handleStartTimeout(entry) {
    this.handlers[0](entry)
    console.log(`SCHEDULER ${(new Date()).toTimeString().slice(0,17)}: Event '${entry.id}' triggered! Event will end at ${(new Date(+entry._computed_timestamp + entry.duration * 1000)).toTimeString().substr(0,8)}`)
    delete this.timeouts[`${entry.id}__start_timeout`]
    this.timeouts[`${entry.id}__end_timeout`] = setTimeout(() => this.handleEndTimeout(entry), entry.duration * 1000)
    this.start()
  }

  handleEndTimeout(entry) {
    this.handlers[1](entry)
    console.log(`SCHEDULER ${(new Date()).toTimeString().slice(0,17)}: Event '${entry.id}' ended.`)
    delete this.timeouts[`${entry.id}__end_timeout`]
    if (!Object.keys(this.timeouts).length && this.progress) {
      clearInterval(this.progress)
    }
  }

  registerHandler(start: (entry: TimelineEntry) => void, end: (entry: TimelineEntry) => void = () => {}) {
    this.handlers = [start, end]
  }

  print() {
    let sorted = Object
      .values(this.entries)
      .sort((a, b) => a._computed_timestamp - b._computed_timestamp)

    let startTimestamp = sorted[0]._computed_timestamp
    let endTimestamp = new Date(+sorted[0]._computed_timestamp + sorted[0].duration * 1000)

    sorted.map(e => {
      const end = new Date(+e._computed_timestamp + e.duration * 1000)
      if (end > endTimestamp) {
        endTimestamp = end
      }
    })

    console.log('SCHEDULER: Current time: ', (new Date).toLocaleString(), '\n')
    Object.values(this.entries)
      .sort((a, b) => a.order - b.order)
      .map(entry => console.log(`SCHEDULER: ${entry.expired ? '! PAST ! ': '         '}#${entry.order} at ${entry._computed_timestamp.toTimeString().slice(0,8)}->${(new Date(+entry._computed_timestamp + entry.duration * 1000)).toTimeString().slice(0, 8)} (${entry.duration > 60 ? `${entry.duration / 60}min` : `${entry.duration}s`}): ${entry.id} ${entry.offset ? `(offset ${entry.offset.delta > 60 ? `${entry.offset.delta / 60}min` : `${entry.offset.delta}s`} from ${entry.offset.from})` : ''}`))

    console.log()
    
    if (!process.stdout.columns) {
      return;
    }
    
    const terminalWidth = Math.floor(process.stdout.columns * .9)
    const timelineLength = (endTimestamp - startTimestamp) / 1000

    console.log([
      startTimestamp.toTimeString().slice(0,8),
      ' ',
      (new Array(Math.max(terminalWidth - 9, 0)).fill('=').join('')),
      ' ',
      endTimestamp.toTimeString().slice(0,8),
      '\n'
    ].join(''))
    
    sorted
      .map(e => {
      const prefix = `${e.id} ${e._computed_timestamp.toTimeString().slice(0,8)} `
      const postfix = ` ${(new Date(+e._computed_timestamp + e.duration * 1000)).toTimeString().slice(0, 8)} (${e.duration > 60 ? `${e.duration / 60}min` : `${e.duration}s`})`

      const offsetFromStart = Math.ceil(((+e._computed_timestamp - startTimestamp) / 1000 / timelineLength) * terminalWidth)
      const barLength = Math.round((e.duration / timelineLength) * terminalWidth)

      const offsetFromBar = new Date > e._computed_timestamp
        ? ((new Date) - e._computed_timestamp) / e.duration / 1000
        : 0

      const padding = (new Array(offsetFromStart)).fill(' ').join('')
      const progress = [
        (new Array(Math.max(Math.round(barLength * Math.min(offsetFromBar, 1)), 0))).fill('*').join(''),
        (new Array(Math.max(Math.round(barLength * Math.min(1 - offsetFromBar, 1)), 0))).fill('-').join(''),
      ].join('')
      
      const bar = [
        prefix.length > padding.length ? padding : padding.slice(0, padding.length - prefix.length) + prefix,
        '+',
        progress.slice(1, -1),
        '+',
        postfix
      ].join('')

      console.log(bar)
    })
    console.log()
  }

  progress(refresh = 5000) {
    this.progress = setInterval(() => {
      console.clear()
      this.print()
    }, refresh)
  }

}

export default TimelineManager