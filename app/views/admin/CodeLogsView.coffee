RootView = require 'views/core/RootView'
CocoCollection = require 'collections/CocoCollection'
CodeLog = require 'models/CodeLog'
template = require 'templates/admin/codelogs'
utils = require 'core/utils'

module.exports = class CodeLogsView extends RootView
  template: template
  constructor: (options) ->
    super options