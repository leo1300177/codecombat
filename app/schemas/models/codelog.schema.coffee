c = require './../schemas'

CodeLogSchema =
  type: 'object'
  properties:
    sessionID: c.objectId()
    levelID: c.objectId()
    levelSlug: {type: 'string'}
    userID: c.objectId()
    userName: {type: 'string'}
    log: {type: 'string'}
    date: c.stringDate()
  additionalProperties: false

module.exports = CodeLogSchema
