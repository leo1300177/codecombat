mongoose = require 'mongoose'
config = require '../../server_config'

CodeLogSchema = new mongoose.Schema({
  created:
    type: Date
    'default': Date.now
}, {strict: false, read: config.mongo.readpref})

CodeLogSchema.index({levelSlug: 1, created: -1}, {name: 'level slug index'})
CodeLogSchema.index({userID: 1, created: -1}, {name: 'user name index'})

CodeLogSchema.statics.editableProperties = [
  'sessionID'
  'level'
  'levelSlug'
  'userID'
  'log'
  'created'
]
CodeLogSchema.statics.jsonSchema = require '../../app/schemas/models/codelog.schema'


module.exports = CodeLog = mongoose.model('CodeLog', CodeLogSchema, 'codelogs')