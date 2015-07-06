var fs = require('fs');
var path = require('path');
var EventEmitter = require('events').EventEmitter;

$$in.actorAliases['<'] = 'read';

$$in.actors.read = function(opts, inArgs, actionArg, actorPath) {

  var readStream, emitter, options;
  var isStream = actionArg.adapters.indexOf('stream') >= 0;
  var isBuffer = actionArg.adapters.indexOf('buffer') >= 0;
  var file = actionArg.expansion.trim();

  if (path.parse(file).root == '') {
    file = path.dirname(opts.$$caller.FileName) + path.sep + file;
  }

  options = util._extend({}, opts);
  options.encoding = Buffer.isEncoding(options.encoding) ? options.encoding : 'utf8';
  options.flag = (options.flag || 'r');

  if (isStream || isBuffer) {
    readStream = fs.createReadStream(file);
    if (isStream && isBuffer) {
      actionArg.value = readStream;
      return
    }

    if (isStream) {
      actionArg.value = emitter = new EventEmitter();

      readStream.on('error', function(e) {
        emitter.emit('error', e);
      });

      readStream.on('end', function() {
        emitter.emit('end');
      });

      readStream.on('data', function(chunk) {
        if (isBuffer) return emitter.emit(data, chunk);
        emitter.emit('data', chunk.toString(options.encoding || 'utf8'));
      });

      return;
    }
  }

  if (isBuffer) delete options.encoding;

  return $$in.promise(function(resolve, reject) {

    fs.readFile(file, options, function(err, data) {
      if (err) return reject(err);
      actionArg.value = data;
      resolve(actionArg);
    })
  });
}

$$in.actors.read.$$can = function(action) {
  return true;
}
