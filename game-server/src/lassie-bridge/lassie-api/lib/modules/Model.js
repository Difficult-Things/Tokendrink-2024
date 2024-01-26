'use strict'

const BaseModule = require('../BaseModule')
    , Instance = require('../Instance')
    , helpers = require('../helpers')

class Model extends BaseModule {

  /**
   * Method call proxy handler
   * @param  {String} model    Proxied model name
   * @param  {String} method   Proxied model method name
   * @param  {Object} lassie   Lassie.Instance object
   * @param  {Object} args     Additional arguments for the API request
   * @param  {Function} cb     Callback function (err | false, res)
   */
  static async call (model, method, lassie, ...args) {

    if ( !(lassie instanceof Instance) ) {
      throw new Error('First method argument must be Lassie instance.')
    }

    method = helpers.to_snake_case(method)
    const name = helpers.to_snake_case(model)
    const type = helpers.getMethodType(method)

    const cb = args[args.length - 1]
    args = args.length > 1 ? args[0] : { }
    const params = { 
      model_name: name, 
      method_name: method, 
      ...args, 
    }

    lassie.performRequest(type, 'model', params, cb)
  }

  /**
   * Model call proxy handler
   * Proxies are a little strange; refer to http://mdn.io/Proxy
   */
  static _get (obj, model, self) {
    // proxy second level calls (i.e., method calls)
    const handler = { get: (t, method) => self.call.bind(self, model, method) }

    return model in obj ? obj[model] : new Proxy({}, handler)
  }

}

// register the proxy handler
module.exports = new Proxy(Model, { get: Model._get })
