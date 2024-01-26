'use strict'

const BaseModule = require('../BaseModule')

class Transaction extends BaseModule {

  /**
   * Perform the GET transaction on the root endpoint.
   * @param {Object} lassie     Lassie.Instance object 
   * @param {Object} opts       Any parameters to be passed with the request
   * @param {Function} cb       Request callback function; (err, res)
   */
  static getTransaction (lassie, opts, cb) {
    lassie.performRequest('GET', 'transaction', opts, cb)
  }

  /**
   * Perform the POST transaction on the root endpoint.
   * @param {Object} lassie     Lassie.Instance object 
   * @param {Object} opts       Any parameters to be passed with the request
   * @param {Function} cb       Request callback function; (err, res)
   */
  static postTransaction (lassie, opts, cb) {
    lassie.performRequest('POST', 'transaction', opts, cb)
  }

}

module.exports = Transaction
