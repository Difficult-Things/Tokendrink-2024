'use strict'

const BaseModule = require('../../BaseModule')

class Membership extends BaseModule {

  // custom endpoint
  get opts () {
    return {
      endpoint: 'person/membership'
    }
  }

}

module.exports = Membership
