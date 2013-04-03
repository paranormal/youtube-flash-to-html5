basedir = '../chrome/content/'
global.document =
  addEventListener: (event) ->
  location:
    hostname: "youtube.com"
  getElementById: (element) ->
global.window =
  document: document
  addEventListener: (event) ->

describe 'detube', ->
  beforeEach ->
    @detube = (require basedir + 'detube').detube
  it 'description', ->
    expect(@detube.init).toBeDefined()
    expect(@detube.onPageLoad).toBeDefined()
    expect(@detube.onPageUnload).toBeDefined()
