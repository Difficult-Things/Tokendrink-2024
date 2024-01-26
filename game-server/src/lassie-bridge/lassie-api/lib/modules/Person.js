'use strict'

const BaseModule = require('../BaseModule')
    , Account = require('./Person/Account')
    , Event = require('./Person/Event')
    , Membership = require('./Person/Membership')
    , API = require('./Person/API')

class Person extends BaseModule {

  /**
   * Lassie.PersonAccount => Lassie.Person.Account
   */
  static get Account () {    
    return Account
  }

  /**
   * Lassie.PersonEvent => Lassie.Person.Event
   */ 
  static get Event () {    
    return Event
  }

  /**
   * Lassie.PersonMembership => Lassie.Person.Membership
   */ 
  static get Membership () {    
    return Membership
  }

  /**
   * Lassie.PersonAPI => Lassie.Person.API
   */ 
  static get API () {    
    return API
  }

}

module.exports = Person
