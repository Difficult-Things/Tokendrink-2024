'use strict'

const BaseModule = require('../../BaseModule')

class API extends BaseModule {

  // custom endpoint
  get opts () {
    return {
      endpoint: 'person/api'
    }
  }

}

module.exports = API
