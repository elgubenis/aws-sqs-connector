# AWS SQS Connector

Tired of all the hassles connecting and polling a Amazon WebService SQS? The solutions is here!

Install
-
```sh
npm install --save aws-sqs-connector
```

Initialize Queue
-
With CoffeeScript
```coffee
SQSConnector = require 'aws-sqs-connector'

Queue = new SQSConnector
  credentials: './credentials/aws.json'
  queueUrl: 'http://sqs.<REGION>.amazonaws.com/<NUMBER>/queue-name'
```


With JavaScript
```js
var SQSConnector = require('aws-sqs-connector');

var Queue = new SQSConnector({
  credentials: './credentials/aws.json',
  queueUrl: 'http://sqs.<REGION>.amazonaws.com/<NUMBER>/queue-name'
});
```

Poll Queue
-
With CoffeeScript
```coffee
# Everytime there is a new message, this callback gets executed
Queue.receive (message, attributes, fetchNext) ->

  # log message
  console.log message

  # log attributes
  console.log attributes

  # do some processing with the message and then fetch the next message
  fetchNext()
```


With JavaScript
```js
Queue.receive(function(message, attributes, fetchNext) {
  console.log(message);
  console.log(attributes);
  fetchNext();
});
```

Send Message
-

```sh
send MessageBody, MessageAttributes, Callback
```

With CoffeeScript
```coffee
Queue.send 'message body', { responseRequired: true, randomNumber: 1 }, (err, response) ->
  console.error(err) if err
  console.log response
```


With JavaScript
```js
Queue.send('message body', { responseRequired: true, randomNumber: 1 }, function(err, response) {
  if (err) { console.error(err); }
  console.log(response);
});
```

Options
---
- Credentials:
The credentials json should be of the following format:
```json
{
  "accessKeyId": "YOUR_ACCESS_KEY_ID",
  "secretAccessKey": "YOUR_SECRET_ACCESS_KEY",
  "region": "YOUR_REGION"
}
```