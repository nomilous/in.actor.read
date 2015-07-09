[![Build Status](https://travis-ci.org/nomilous/in.actor.read.svg)](https://travis-ci.org/nomilous/in.actor.read)

# in.actor.read

File reader for [in.](https://github.com/nomilous/in.)

This actor is bundled with in.

```javascript
$$in(function(readme) { // in. read README.md
  
})
```

It can be accessed with alias __<__

```javascript
$$in(function(readme) { // in. < README.md
  
})
```

```javascript
$$in(function(lines) { // in.as.lines < ./README.md
  
})
```

```javascript
$$in(function(stream) { // in.as.stream < {{process.cwd()}}/README.md
  stream.on('data', ...
  stream.on('end', ...
  stream.on('error', ...
})
```

```javascript
$$in(function(streams) { // in.as.stream.lines < {{ $$files('~/repos/**/README.md') }}
  streams.forEach(function(stream) {
    // one stream per found readme
    stream.on('data', ... // for each line
    stream.on('end', ...
    stream.on('error', ...
})
```

```javascript
$$in(function(raw) { // in.as.buffer < CANT_README
  
})
```

```javascript
$$in(function(raw) { // in.as.stream.buffer < /dev/random
  stream.on('data', ...
  stream.on('end', ...
  stream.on('error', ...
})
```

NB __It accepts only one filename!__

```javascript
$$in(function(lines) { // in.as.lines < file1.txt file2.txt
    
  // will attempt to read 'file1.txt file2.txt'
})
```
