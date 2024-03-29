const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)

// const vueRule = environment.loaders.get('vue')
// vueRule.test = /\.vue$/
// vueRule.use[0].options.extractCSS = false // Add this line to disable CSS extraction

module.exports = environment
