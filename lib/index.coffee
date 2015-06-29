{ constructor, receive, send } = require './modules'

class SQSConnector
  constructor:  constructor
  receive:      receive
  send:         send

module.exports = SQSConnector