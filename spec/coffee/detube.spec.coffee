describe 'detube', ->

  beforeEach ->
    app = require("#{__dirname}/../helpers/specHelper")
    document = createSpyObj('document',
      ['addEventListener', 'location', 'getElementById'])
    global.document = document
    window = createSpyObj('window',
      ['document', 'addEventListener', 'addEventListener'])
    global.window = window
    @detube = (require basedir + 'detube').detube

  it 'definition', ->
    expect(@detube.init).toBeDefined()
    expect(@detube.onPageLoad).toBeDefined()
    expect(@detube.onPageUnload).toBeDefined()
