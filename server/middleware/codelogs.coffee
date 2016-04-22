errors = require '../commons/errors'
wrap = require 'co-express'
database = require '../commons/database'

mongoose = require 'mongoose'
CodeLog = require '../models/CodeLog'
LevelSession = require '../models/LevelSession'

module.exports =
  post: (Model, options={}) -> wrap (req, res) ->
    doc = database.initDoc(req, Model)
    database.assignBody(req, doc)
    database.validateDoc(doc)
    doc = yield doc.save()

    # Update the level session with sessionID to include the new codelog.
    yield LevelSession.update(
      {_id: mongoose.Types.ObjectId(req.body.sessionID)},
      {$push:{codeLogs: doc._id}}
    )

    res.status(201).send(doc.toObject())
