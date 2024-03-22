const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')
const NodePolyfillPlugin = require('node-polyfill-webpack-plugin')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
environment.plugins.prepend('NodePolyfillPlugin', new NodePolyfillPlugin())

module.exports = environment
