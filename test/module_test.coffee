objective 'read', (should) ->

    trace.filter = true

    before ->

        global.$$in = global.$$in ||
            actors: {}
            actorAliases: {}

        delete global.$$in.actors.read
        delete global.$$in.actorAliases['<']

    beforeEach ->

        @opts = 
            $$caller:
                FileName: '/some/home/location/file'
        @inArgs = {}
        @actionArg =
            action: ['in', 'as']
            adapters: []
            expansion: ''
            toString: ->
        @actorPath = []



    it 'creates actor and alias', (Module) ->

        global.$$in.actors.read.should.be.an.instanceof Function
        global.$$in.actorAliases['<'].should.equal 'read'


    it 'reads the specified file', (Module, fs, done) ->

        @actionArg.expansion = '/filename'

        fs.does readFile: (path) ->

            path.should.equal '/filename'
            done()

        Module @opts, @inArgs, @actionArg, @actorPath
        .catch done


    it 'reads relative to in caller', (Module, fs, done) ->

        @actionArg.expansion = 'filename'

        fs.does readFile: (path) ->

            path.should.equal '/some/home/location/filename'
            done()

        Module @opts, @inArgs, @actionArg, @actorPath
        .catch done


    it 'reads relative to in caller', (Module, fs, done) ->

        @actionArg.expansion = './filename'

        fs.does readFile: (path) ->

            path.should.equal '/some/home/location/filename'
            done()

        Module @opts, @inArgs, @actionArg, @actorPath
        .catch done


    it 'returns the file contents', (Module, fs, done) ->

        @actionArg.expansion = './filename'

        fs.does readFile: (path, opts, cb) ->

            cb null, 'DATA'

        Module @opts, @inArgs, @actionArg, @actorPath

        .then (r) ->

            r.value.should.equal 'DATA'
            done()
        
        .catch done


    it 'can return a data event stream', (Module, fs, done) ->

        @actionArg.expansion = './filename'
        @actionArg.adapters = ['stream']

        fs.does createReadStream: (path) -> on: -> 

        Module @opts, @inArgs, @actionArg, @actorPath

        @actionArg.value.on 'data', ->
        done()


    it 'can reutrn as undecoded buffer', (Module, fs, done) ->

        @actionArg.expansion = './filename'
        @actionArg.adapters = ['buffer']

        fs.does createReadStream: (path) -> on: ->

        fs.does readFile: (path, opts, cb) ->

            should.not.exist opts.encoding
            done()

        Module @opts, @inArgs, @actionArg, @actorPath




