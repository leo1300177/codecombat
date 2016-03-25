CodeLog = require './CodeLog'
Handler = require '../commons/Handler'
mongoose = require 'mongoose'

CodeLogHandler = class CodeLogHandler extends Handler
  modelClass: CodeLog
  makeNewInstance: (req) ->
    codelog = super(req)
    codelog.id = req.id
    codelog.set 'sessionID', req.body.sessionID
    codelog.set 'level', req.body.level
    codelog.set 'levelSlug', req.body.levelSlug
    codelog.set 'userID', req.body.userID
    codelog.set 'userName', req.body.userName
    codelog.set 'log', req.body.log
    codelog.set 'date', new Date().toISOString()
    codelog.set 'id', req.body.id

    return codelog

  post: (req, res) ->
    super(req, res)

module.exports = new CodeLogHandler()
