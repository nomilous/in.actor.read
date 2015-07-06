# in.actor.read

File reader for [in.](https://github.com/nomilous/in.)

This actor is bundled with in.

eg.

```javascript
$$in(function(readme) { // in. read README.md
  
})
```

```javascript
$$in(function(lines) { // in.as.lines read ./README.md
  
})
```

```javascript
$$in(function(stream) { // in.as.stream read {{process.cwd()}}/README.md
  stream.on('data', ...
  stream.on('end', ...
  stream.on('error', ...
})
```

```javascript
$$in(function(streams) { // in.as.stream.lines read {{ $$files('~/repos/**/README.md') }}
  streams.forEach(function(stream) {
    // one stream per found readme
    stream.on('data', ... // for each line
    stream.on('end', ...
    stream.on('error', ...
})
```

```javascript
$$in(function(raw) { // in.as.buffer read CANT_README
  
})
```

```javascript
$$in(function(raw) { // in.as.stream.buffer read /dev/random
  stream.on('data', ...
  stream.on('end', ...
  stream.on('error', ...
})
```

NB __It accepts only one filename!__

```javascript
$$in(function(lines) { // in.as.lines read file1.txt file2.txt
    
  // will attempt to read 'file1.txt file2.txt'
})
```
