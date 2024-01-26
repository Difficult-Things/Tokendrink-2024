'use strict'

const axios = require('axios')
    , crypto = require('crypto')
    , url = require('url')

class Instance {

  /**
   * Lassie API Instance constructor.
   * @param {String} api_host   API host, e.g. http://lassie.example.cloud/api
   * @param {String} api_key    API key
   * @param {String} api_secret API secret
   * @param {Boolean} log       Should requests be logged to console
   */
  constructor (api_host, api_key, api_secret, log = false) {
    this.API_HOST = api_host
    this.API_KEY = api_key
    this.API_SECRET = api_secret
    this.LOG = log
  }

  /**
   * Checks whether the instance API keys are valid.
   * @param {Function} cb Request callback; cb(isValid)
   */
  validate (cb) {
    this.performRequest('GET', 'get_validity', {}, (err, res) =>
      cb(!!(!err && res.status)))
  }

  /**
   * Build and perform the request.
   * @param  {String}   method   HTTP request method
   * @param  {String}   endpoint API endpoint (appended to API_HOST)
   * @param  {Object}   params   Any parameters to be passed with the request
   * @param  {Function} cb       Request callback function; (err, res)
   * @param  {object}   hashArgs Optional, specify hash params for the request
   */
  performRequest (method, url, params, cb, hashArgs = this._generateHashArgs()) {
    // construct the API request params
    const data = { ...params, ...hashArgs }
    const serialized = Object.entries(data)
            .map(arr => `${arr[0]}=${encodeURIComponent(arr[1])}`)
            .join('&')
    
    const options = {
      method,
      baseURL: this.API_HOST,
      url: `${url}?${serialized}`,
      data
    }
    
    Instance._performRequest(options, cb, this.LOG)
  }

  /**
   * Performs the request
   * @param {Object} options Request options
   * @param {Function} cb    Request callback function; (err, res)
   */
  static _performRequest (options, cb, log = false) {
    if (log) console.log(options)

    axios(options)
      .then(res => cb(false, res))
      .catch(err => cb(err))
  }

  /**
   * Generates request parameters required for Lassie API authentication.
   * @return {Object} { api_key, api_hash, api_hash_content }
   */
  _generateHashArgs () {
    const hashContent = crypto.randomBytes(32).toString('base64')
    const hashDigest = crypto.createHmac('sha256', this.API_SECRET)
                             .update(`${this.API_KEY}:${hashContent}`)
                             .digest('hex')
    const hashBase64 = Buffer(hashDigest).toString('base64')

    return {
      api_key: this.API_KEY,
      api_hash_content: hashContent,
      api_hash: hashBase64
    }
  }

}

module.exports = Instance
