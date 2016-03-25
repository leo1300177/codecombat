mongoose = require 'mongoose'
config = require '../../server_config'

CodeLogSchema = new mongoose.Schema({
  sessionID: String
  levelID: String
  levelSlug: String
  userID: String
  userName: String
  log: String
  date: String
}, {strict: false, read:config.mongo.readpref})

module.exports = CodeLog = mongoose.model('codelog', CodeLogSchema)