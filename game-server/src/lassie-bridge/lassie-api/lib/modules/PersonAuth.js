'use strict'

const BaseModule = require('../BaseModule')
    , Instance = require('../Instance')

class PersonAuth extends BaseModule {

  // custom endpoint
  get opts () {
    return {
      endpoint: 'auth/login'
    }
  }

    /**
   * Performs the initial Person Auth request to generate a person-specific
   * API instance.
   * @param {Object} lassie     Lassie.Instance object 
   * @param {String} username   Person username
   * @param {String} password   Person password
   * @param {Function} cb       Callback function (takes Person object as sole arg)
   */
  static getPerson (lassie, { username, password }, cb) {

    if ( !(lassie instanceof Instance) ) {
      throw new Error('First method argument must be Lassie instance.')
    }

    const preProcess = (err, response) => {
        if (err) {
          if (lassie.LOG) console.log(err)
          return cb(err)
        }

        const personInstance = new Instance(
            lassie.API_HOST,
            response.data.api_key,
            response.data.api_secret,
            lassie.LOG
        )
        cb(null, personInstance)
    }
    
    lassie.performRequest('POST', 'auth/login', { username, password }, preProcess)
  }

}

module.exports = PersonAuth
