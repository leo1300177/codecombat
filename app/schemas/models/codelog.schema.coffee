c = require './../schemas'

LevelVersionSchema = c.object {required: ['original', 'majorVersion'], links: [{rel: 'db', href: '/db/level/{(original)}/version/{(majorVersion)}'}]},
  original: c.objectId({})
  majorVersion:
    type: 'integer'
    minimum: 0  

CodeLogSchema =
  type: 'object'
  properties:
    sessionID: c.objectId()
    level: LevelVersionSchema
    levelSlug: {type: 'string'}
    userID: c.objectId()
    userName: {type: 'string'}
    log: {type: 'string'}
    created: c.stringDate()
  additionalProperties: false

module.exports = CodeLogSchema
