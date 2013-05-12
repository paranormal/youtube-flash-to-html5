describe 'Detube', ->

  Detube = null
  detube = null

  beforeEach ->
    app = require("#{__dirname}/../helpers/specHelper")
    Detube = (require "#{__dirname}/../../src/detube").Detube
    detube = new Detube(doc)

  it '.', ->
    expect(Detube.exposedProps.getPlayerState).toEqual('r')
    expect(Detube.exposedProps.hasFallbackHappened).toEqual('r')
    expect(Detube.exposedProps.getVideoData).toEqual('r')

  it '.new', ->
    expect(detube.doc).toEqual(doc)
    expect(detube.document).toEqual(doc.defaultView.wrappedJSObject.document)

  describe '.valid', ->
    it 'How doth the little crocodile Improve his shining tail,', ->

      spyOn(detube, 'valid_domain').andReturn(true)
      spyOn(detube, 'valid_play').andReturn(true)

      expect(detube.valid()).toBeTruthy()
      expect(detube.valid_domain).toHaveBeenCalled()
      expect(detube.valid_play).toHaveBeenCalled()

      detube.valid_play.andReturn(false)
      expect(detube.valid()).toBeFalsy()

      detube.valid_domain.andReturn(false)
      expect(detube.valid()).toBeFalsy()


      detube.valid_play.andReturn(true)
      expect(detube.valid()).toBeFalsy()


  describe '#valid_domain', ->
    it 'And pour the waters of the Nile On every golden scale!', ->
      expect(detube.valid_domain()).toBeTruthy()
      doc.location.hostname = 'detube'
      expect(detube.valid_domain()).toBeFalsy()
      doc.location.hostname = 'youtube'
      doc.getElementById.andReturn(false)
      expect(detube.valid_domain()).toBeFalsy()


  describe '#vadil_play', ->
    it 'How cheerfully he seems to grin How neatly spreads his claws,', ->


  describe '#load', ->
    it ' And welcomes little fishes in, With gently smiling jaws!  ', ->
      
