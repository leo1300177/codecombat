mongoose = require 'mongoose'
config = require '../../server_config'

CodeLogSchema = new mongoose.Schema({
  #sessionID: String
  #levelID: String
  #levelSlug: String
  #userID: String
  #userName: String
  #log: String
  #date: String
  created:
    type: Date
    'default': Date.now
}, {strict: false, read:config.mongo.readpref})

module.exports = CodeLog = mongoose.model('code.log', CodeLogSchema)