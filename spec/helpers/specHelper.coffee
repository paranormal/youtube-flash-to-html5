global.basedir = "#{__dirname}/../../src/"

global.doc = createSpyObj('doc', ['getElementById', 'location', 'defaultView'])

doc.getElementById.andReturn(true)
doc.location = {hostname: 'youtube.com'}
doc.defaultView =
  wrappedJSObject:
    document:
      getElementById: (id) ->
        getPlayerState: -> 3
