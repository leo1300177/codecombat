CocoModel = require './CocoModel'

module.exports = class CodeLog extends CocoModel
  @className: 'CodeLog'
  urlRoot: '/db/codelogs'
  @schema: require 'schemas/models/codelog.schema'
  initialize: ->
    super()
