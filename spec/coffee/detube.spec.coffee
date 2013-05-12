describe 'Detube', ->

  Detube = null
  detube = null
  # player = null

  beforeEach ->
    app = require("#{__dirname}/../helpers/specHelper")

    Detube = (require "#{__dirname}/../../src/detube").Detube

    # player = createSpyObj('player',
    # ['getPlayerState', 'loadVideoById', 'getVideoData'])
    # player.getVideoData.andReturn(video_id: 'T-Eoretov.')
    # player.loadVideoById.andReturn(true)

    detube = new Detube(doc)
    # detube.player = player


  it '.', ->
    expect(Detube.exposedProps.getPlayerState).toEqual('r')
    expect(Detube.exposedProps.hasFallbackHappened).toEqual('r')
    expect(Detube.exposedProps.getVideoData).toEqual('r')

  it '.new', ->
    expect(detube.doc).toEqual(doc)
    expect(detube.document).toEqual(doc.defaultView.wrappedJSObject.document)

  describe '.valid', ->
    it 'How doth the little crocodile Improve his shining tail,', ->
    # it 'And pour the waters of the Nile On every golden scale!', ->
      expect(detube.valid()).toBeTruthy()
      doc.location.hostname = 'detube'
      expect(detube.valid()).toBeFalsy()
      doc.location.hostname = 'youtube'
      doc.getElementById.andReturn(false)
      expect(detube.valid()).toBeFalsy()


    # it 'How cheerfully he seems to grin How neatly spreads his claws,', ->

  describe '#player', ->
    it 'description', ->
      player =
        doc.defaultView.wrappedJSObject.document.getElementById('movie_player')
      player.__exposedProps__ = Detube.exposedProps
      expect(detube.player()).toBeFalsy()

  describe '#status', ->
    it 'description', ->
      # expect(detube.status).toBeDefined()
      # player = createSpyObj('player', ['getPlayerState', ''])

  describe '#load', ->
    it ' And welcomes little fishes in, With gently smiling jaws!  ', ->
      spyOn(detube, 'valid').andReturn(null)
      spyOn(detube, 'proceed')
      detube.load()
      expect(detube.proceed).not.toHaveBeenCalled()
      detube.valid.andReturn(true)
      detube.load()
      expect(detube.proceed).toHaveBeenCalled()
