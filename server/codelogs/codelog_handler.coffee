CodeLog = require './CodeLog'
Handler = require '../commons/Handler'
mongoose = require 'mongoose'

CodeLogHandler = class CodeLogHandler extends Handler
  modelClass: CodeLog
  #post: (req, res) ->
  makeNewInstance: (req) ->
    codelog = super(req)
    #console.log(req)
    codelog.id = req.id
    codelog.set 'sessionID', req.body.sessionID
    codelog.set 'levelID', req.body.levelID
    codelog.set 'levelSlug', req.body.levelSlug
    codelog.set 'userID', req.body.userID
    codelog.set 'userName', req.body.userName
    codelog.set 'log', req.body.log
    codelog.set 'date', new Date().toISOString()
    codelog.set 'id', req.body.id

    return codelog

  post: (req, res) ->
    super(req, res)
    #return @sendSuccess(res, @formatEntity(req, ))
  ###
  post: (req, res) ->
+    sold = req.body.sold
+    seller = req.user._id
+    soldOriginal = sold?.original
+
+    Handler = require '../commons/Handler'
+    return @sendBadInputError(res) if not Handler.isID(soldOriginal)
+
+    collection = sold?.collection
+    return @sendBadInputError(res) if not collection in @jsonSchema.properties.sold.properties.collection.enum
+
+    handler = require('../' + handlers[collection])
+    criteria = { 'original': soldOriginal }
+    sort = { 'version.major': -1, 'version.minor': -1 }
+
+    handler.modelClass.findOne(criteria).sort(sort).exec (err, soldItem) =>
+      gemsOwned = req.user.get('earned')?.gems or 0
+      return @sendDatabaseError(res, err) if err
+      return @sendNotFoundError(res) unless soldItem
+      req.soldItem = soldItem # for safekeeping
+
+      criteria = {
+        'sold.original': soldOriginal
+        'recipient': seller
+      }
+      Sale.findOne criteria, (err, sale) =>
+        if sale
+          @addSaleToUser(req, res)
+          return @sendSuccess(res, @formatEntity(req, sale))
+
+        else
+          super(req, res)
  ###

module.exports = new CodeLogHandler()