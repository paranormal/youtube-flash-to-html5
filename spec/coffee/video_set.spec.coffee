describe 'VideoSet', ->

  videoSet = null

  beforeEach ->
    app = require("#{__dirname}/../helpers/specHelper")
    # global.Collector = createSpyObj('Collector', ['data'])
    global.Collector = require("#{basedir}/collector").Collector
    global.Video = require("#{basedir}/video").Video
    videoSet = new (require basedir + 'video_set').VideoSet(doc)

  describe '#text', ->
    it 'How doth the little crocodile Improve his shining tail', ->
      expect(videoSet.text).toBeDefined()

  describe '#data', ->
    it 'And pour the waters of the Nile On every golden scale', ->
      expect(videoSet.data).toBeDefined()

  describe '#type', ->
    it 'How cheerfully he seems to grin', ->
      expect(videoSet.type).toBeDefined()
      mockVid = [{to_h: -> itag: 5}, {to_h: -> itag: 43}, {to_h: -> itag: 46}]
      spyOn(videoSet, 'data').andReturn(mockVid)
      expect(videoSet.type()[0].to_h().itag).toEqual(43)
      expect(videoSet.type()[1].to_h().itag).toEqual(46)
      expect(videoSet.data).toHaveBeenCalled()

  xdescribe '#quality', ->
    it 'How neatly spread his claws', ->
      expect(videoSet.quality()).toBeDefined()
      mockVid = [{to_h: -> itag: '5'}, {to_h: -> itag: '43'}, {to_h: -> itag: '46'}]
      spyOn(videoSet, 'type').andReturn(mockVid)
      expect(videoSet.quality().to_h()).toEqual({itag: '46'})
      videoSet.type.andReturn([{to_h: -> itag: '5'}, {to_h: -> itag: '43'}, {to_h: -> itag: '45'}])
      expect(videoSet.quality().to_h()).toEqual({itag: '45'})
      expect(videoSet.type).toHaveBeenCalled()

  describe '#get', ->
    it 'And welcome little fishes in With gently smiling jaws', ->
      type = createSpyObj('type', ['to_uri'])
      type.to_uri.andReturn('string')
      spyOn(videoSet, 'quality').andReturn(type)
      expect(videoSet.get()).toMatch(/string/)
