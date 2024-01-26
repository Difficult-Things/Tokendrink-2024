'use strict'

const BaseModule = require('../../BaseModule')

class Event extends BaseModule {

  // custom endpoint
  get opts () {
    return {
      endpoint: 'person/event'
    }
  }

}

module.exports = Event
