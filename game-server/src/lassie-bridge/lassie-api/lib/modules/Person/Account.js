'use strict'

const BaseModule = require('../../BaseModule')

class Account extends BaseModule {

  // custom endpoint
  get opts () {
    return {
      endpoint: 'person/account'
    }
  }

}

module.exports = Account
