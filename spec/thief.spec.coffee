basedir = '../chrome/content/'
fixtdir = './fixtures/'
fixtures = (require fixtdir + 'tube').fixtures


describe 'Thief', ->
  beforeEach ->
    @document =
      addEventListener: (event) ->
      location:
        hostname: "youtube.com"
      getElementById: (element) ->
        if element is 'player'
          i = innerHTML: fixtures.url_e_f_s_m
          childNodes: [0,1,2, i]
        else if element is 'watch7-container'
          true
    Thief = (require basedir + 'detube').Thief
    @thief = new Thief(@document)

  describe 'new', ->
    it 'should have @doc', ->
      expect(@thief.doc).toEqual(@document)

  describe 'raw_js', ->
    it 'should provide getter for raw element', ->
      expect(@thief.raw_js()).toBe(fixtures.url_e_f_s_m)

  describe 'raw_data', ->
    it 'should find and unescape found data', ->
      expect(@thief.raw_data()).not.toContain(fixtures.js_data.flv.large)
      expect(@thief.raw_data()).not.toContain(fixtures.js_data.flv.medium)
      expect(@thief.raw_data()).not.toContain(fixtures.js_data.flv.small)
      expect(@thief.raw_data()).not.toContain(fixtures.js_data.gpp.small)
      expect(@thief.raw_data()).not.toContain(fixtures.js_data.mp4.small)
      expect(@thief.raw_data()).not.toContain(fixtures.js_data.mp4.large)
      expect(@thief.raw_data()).not.toContain(fixtures.js_data.mp4.hd1080)
      expect(@thief.raw_data()).toContain(fixtures.js_data.webm.hd1080)
      expect(@thief.raw_data()).toContain(fixtures.js_data.webm.medium)
      expect(@thief.raw_data()).toMatch(/U0hVSVVNT19KTENONV9NR1NGOkZocUlTSlQw/)

  describe 'valid_data', ->
    it 'should find proper data', ->
      expect(@thief.valid_data(fixtures.js_data.flv.large)).toBeFalsy()
      expect(@thief.valid_data(fixtures.js_data.gpp.small)).toBeFalsy()
      expect(@thief.valid_data(fixtures.js_data.mp4.hd720)).toBeFalsy()
      expect(@thief.valid_data(fixtures.js_data.webm.hd1080)).toBeTruthy()
      expect(@thief.valid_data(fixtures.js_data.webm.hd720)).toBeTruthy()
      expect(@thief.valid_data(fixtures.js_data.webm.medium)).toBeTruthy()

  describe 'data', ->
    it 'should parse proper data', ->
      expect(@thief.data()).toContain(fixtures.data.webm.hd1080)
      expect(@thief.data()).toContain(fixtures.data.webm.hd720)
      expect(@thief.data()).toContain(fixtures.data.webm.large)
      expect(@thief.data()).toContain(fixtures.data.webm.medium)
      expect(@thief.data()).not.toContain(fixtures.data.gpp)

  describe 'to_hash', ->
    it 'should convert array into hash', ->
      expect(@thief.to_hash()).toEqual(fixtures.data.hash)

  describe 'quality', ->
    it 'should always find the best quality', ->
      expect(@thief.quality()).toEqual(fixtures.data.webm.hd1080)
      expect(@thief.quality([44,43])).toEqual(fixtures.data.webm.large)

  describe 'build', ->
    it 'should build uri', ->
      expect(@thief.build(fixtures.data.webm.medium)).toEqual(fixtures.video)
