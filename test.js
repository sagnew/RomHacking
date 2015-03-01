var fs = require('fs'),
    path = require('path'),
    request = require('request');

var filePath = path.join(__dirname, 'start.html'),
    previousOutput = 0;

try {
  // input/output with respect to the lua script.
  var output = parseInt(fs.readFileSync('output.txt'), 10);
} catch (err) {
  console.error(err);
}

setInterval(function() {
  if(output > previousOutput) {
    request.get('http://bearcatfacts.info', function(err, res, body) {
      if(err) { console.log(err); return; }
      console.log(body);
      fs.writeFileSync('input.txt', body);
    });
  }
}, 1000);
