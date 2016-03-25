CocoModel = require('./CocoModel')

module.exports = class CodeLog extends CocoModel
  @className: 'CodeLog'
  urlRoot: '/db/codelog'
  @schema: require 'schemas/models/codelog.schema'
