module.exports = {

  /**
   * Convert camelCase strings to snake_case
   * @param {String} string   camelCase string
   */
  to_snake_case: string => {
    const pattern = /(.)([A-Z])/g
    return string.replace(pattern, '$1_$2').toLowerCase()
  },

  /**
   * Determine HTTP method type based on method name (e.g., get_groups -> GET)
   * @param {String} string   Method name in snake_case
   */
  getMethodType: method => {
    const keyword = method.split('_')[0]

    const getPrefixes = ['get', 'is', 'has']
    const postPrefixes = ['create', 'switch', 'deactivate', 'activate', 'reset',
                          'insert', 'revoke', 'start', 'end', 'remove', 'update',
                          'delete', 'save', 'end', 'open', 'rename',  'accept',
                          'decline', 'cancel', 'register', 'login', 'increase',
                          'decrease', 'set', 'handle', 'reset', 'generate', 'select',
                          'import', 'commit', 'upsert', 'handle', 'execute', 'transfer',
                          'prohibit', 'grant', 'unlink', 'connect', 'pay', 'invite',
                          'disconnect', 'convert', 'resolve', 'check', 'upgrade']

    switch(true) {
        case postPrefixes.includes(keyword):
          return 'POST'
          break
        
        case getPrefixes.includes(keyword):
          return 'GET'
          break
        
        default:
          return 'GET'
          break
      }
  }

}
