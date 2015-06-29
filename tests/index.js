var assert = require('assert');
var SQSConnector = require('../index.js');

var Queue = new SQSConnector({
  credentials: 'config/aws.json',
  queueUrl: require(process.cwd() + '/config/aws.json').queueUrl
});

describe('AWS SQS Connector', function() {
  it('Instantiate a new Queue from the AWS SQS Connector', function() {
    assert.equal(Queue instanceof SQSConnector, true);
  });
  it('Sends a message to the Queue', function(done) {
    Queue.send('test', function(err) {
      if (err) { throw err; }
      done();
    });
  });
  it('Receives a message from the Queue', function(done) {
    Queue.receive(function(message, next) {
      next();
      done();
    });
  });
});