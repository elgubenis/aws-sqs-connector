utils = require './utils'

exports.constructor = (options) ->
  @options = options
  AWS = require 'aws-sdk'
  credentialsPath = options.credentials
  AWS.config.loadFromPath(credentialsPath)
  @sqs = new AWS.SQS()
  return @

exports.receive = (cb) ->
  @sqs.receiveMessage
    QueueUrl: @options.queueUrl
    MaxNumberOfMessages: 1
    VisibilityTimeout: 60
    WaitTimeSeconds: 0
    MessageAttributeNames: ['All']
  , (err, data) =>
    if err then throw err
    if data.Messages
      for message in data.Messages
        done = (err2) =>
          if err2
            console.error err2
          if !err2 or String(err2).indexOf(404) > -1
            @sqs.deleteMessage
              QueueUrl: @options.queueUrl
              ReceiptHandle: message.ReceiptHandle
            , (err) =>
              @receive(cb)
          else
            @receive(cb)
        returnMessage =
          Id: message.MessageId
          Body: message.Body
          Attributes: utils.getAllAttributes(message)
          ReceiptHandle: message.ReceiptHandle
        return cb returnMessage, done
      @receive(cb)

exports.send = (body, attributes, cb) ->

  # if no attributes passed, the second
  # parameter is the callback
  if !cb
    cb = attributes
    attributes = null

  # set params
  params =
    QueueUrl: @options.queueUrl
    MessageBody: body

  # generate and set messageattributes if attributes passed
  if attributes
    attributes = utils.setAllAttributes(attributes)
    params.MessageAttributes = attributes

  # sendMessage to queue
  @sqs.sendMessage params, (err, data) ->
    cb(err, data)