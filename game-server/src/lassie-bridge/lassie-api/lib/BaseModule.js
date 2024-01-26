'use strict'

const Instance = require('./Instance')
    , helpers = require('./helpers')

class BaseModule {

  /**
   * Return various settings for the module.
   * Modules with custom endpoints should redefine this.
   */
  get opts () {
    return {
      endpoint: this.constructor.name.toLowerCase()
      // urlSeparator: '/'
    }
  }

  /**
   * Proxied method calls.
   * @param  {String} method    Proxied method name
   * @param {Object} lassie     Lassie.Instance object
   * @param  {*} args           Proxied arguments
   */
  static call (method, lassie, ...args) {

    if ( !(lassie instanceof Instance) ) {
      throw new Error('First method argument must be Lassie instance.')
    }

    method = helpers.to_snake_case(method)
    const type = helpers.getMethodType(method)
    
    // Module.create -> POST module/create
    // Module.createSomething -> POST module/something
    if (method.indexOf('_') > -1) {
      method = method.split('_').slice(1).join('_')
    }
    
    const cb = args[args.length - 1]
    args = args.length > 1 ? args[0] : { }

    const urlSeparator = this.opts.urlSeparator ? this.opts.urlSeparator : '/'
    const url = [this.opts.endpoint, urlSeparator, method].join('')

    lassie.performRequest(type, url, args, cb)
  }

  /**
   * Proxy handler to catch inexistant method calls.
   */
  static _get (obj, method, self) {
    return method in obj ? obj[method] : self.call.bind(self.prototype, method)
  }

}

module.exports = new Proxy(BaseModule, { get: BaseModule._get })
