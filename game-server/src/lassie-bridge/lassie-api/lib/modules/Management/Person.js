'use strict'

const BaseModule = require('../../BaseModule')

class Person extends BaseModule {

  // custom endpoint
  get opts () {
    return {
      endpoint: 'management/person'
    }
  }

}

module.exports = Person
