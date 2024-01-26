/* config-overrides.js */
const webpack = require("webpack")
const ModuleScopePlugin = require('react-dev-utils/ModuleScopePlugin');
const path = require('path');

module.exports = function override(config, env) {

    config.resolve.fallback = {
        ...config.resolve.fallback,
        url: require.resolve('url/'),
        buffer: require.resolve('buffer')
    }

    config.resolve.plugins = config.resolve.plugins.filter(plugin => !(plugin instanceof ModuleScopePlugin));

    config.module.rules.find((r) => 'oneOf' in r).oneOf
      .forEach((r) => {
        if ('include' in r) {
          r.include = [
            r.include,
            path.resolve('..', 'specifications'),
          ]
        }
      });

    config.plugins = (config.plugins || []).concat([
        new webpack.ProvidePlugin({
          process: "process/browser",
          Buffer: ["buffer", "Buffer"],
        }),
      ]);

    //do stuff with the webpack config...
    return config;
  }