describe 'Video', ->

  video = null

  beforeEach ->
    app = require("#{__dirname}/../helpers/specHelper")
    video = new (require basedir + 'video').Video(doc)

  describe '.new', ->
    it 'how to get dry again', ->
      expect(video.data).toBe(doc)

  describe '#clean', ->
    it 'Speak English!', ->
      video.data = '%2C,'
      expect(video.clean).toBeDefined()
      expect(video.clean()).toEqual(',,')

  describe '#to_a', ->
    beforeEach ->
      spyOn(video, 'clean').andReturn('a=1&b=2&url=ht?mt=m&sig=1&type=oo')

    it 'First it marked out a race-course', ->
      expect(video.to_a).toBeDefined()
      expect(video.to_a()).toContain('a=1')
      expect(video.to_a()).toContain('mt=m')
      expect(video.to_a()).not.toContain('type=oo')

    it 'signature', ->
      expect(video.to_a()).toContain('signature=1')

    it '#url', ->
      expect(video.to_a()).not.toContain('url=ht?mt=m')
      expect(video.to_a()).not.toContain('type=oo')
      expect(video.url).toEqual('ht')

    it 'in a sort of circle', ->
      spyOn(video, "to_a").andReturn(['a=x', 'c=d', 'quality=hd1080'])
      expect(video.to_h()).toEqual({a: 'x', c: 'd'})
      expect(video.to_h()).not.toEqual({ quality: 'hd1080' })

  describe '#to_uri', ->
    it 'oo', ->
      spyOn(video, "to_a").andReturn(['quality=hd720', 'itag=45'])
      video.url = 'h'
      expect(video.to_uri()).toEqual('h?quality=hd720&itag=45')
