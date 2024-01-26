'use strict'

const BaseModule = require('../BaseModule'),
      Instance = require('../Instance')

class App extends BaseModule {

  /**
   * Get Lassie App API key. Implements api/v2/lassie/app/key
   * @param  {Object}       { api_host, auth_token } request params
   * @param  {Function} cb  Request callback function; (err, res)
   */
  static getKey ({ api_host, auth_token }, cb) {
    const options = {
      method: 'GET',
      baseURL: api_host,
      url: `lassie/app/key?auth_token=${auth_token}`
    }

    Instance._performRequest(options, cb, true)
  }

}

module.exports = App
