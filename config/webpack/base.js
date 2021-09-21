const WebPack = require('webpack');

const { webpackConfig, merge } = require('@rails/webpacker');

module.exports = merge(webpackConfig, {
  resolve: {
    alias: {
      // jquery: 'jquery/src/jquery',
      // Popper: ['@popplerjs/core', 'default'],
    }
  },
  optimization: {
    splitChunks: {
      chunks: 'async',
      minSize: 20000,
      minRemainingSize: 0,
      minChunks: 1,
      maxAsyncRequests: 30,
      maxInitialRequests: 30,
      enforceSizeThreshold: 50000,
      cacheGroups: {
        defaultVendors: {
          test: /[\\/]node_modules[\\/]/,
          priority: -10,
          reuseExistingChunk: true,
        },
        default: {
          minChunks: 2,
          priority: -20,
          reuseExistingChunk: true,
        },
      },
    },
  },
})
