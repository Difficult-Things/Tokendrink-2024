'use strict'

module.exports = {
  BaseModule: require('./lib/BaseModule'),

  // api classes
  Instance: require('./lib/Instance'),
  App: require('./lib/modules/App'),
  Person: require('./lib/modules/Person'),
  PersonAuth: require('./lib/modules/PersonAuth'),
  // PersonAccount: require('./lib/modules/PersonAccount'),
  Model: require('./lib/modules/Model'),
  Transaction: require('./lib/modules/Transaction'),
  Management: {
    Person: require('./lib/modules/Management/Person')
  }
}
