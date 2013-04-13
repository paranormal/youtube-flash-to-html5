basedir = '../../chrome/content/'
fixtdir = '../fixtures/'
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

  it 'four times five is twelve', ->
    expect(@thief.doc).toEqual(@document)

  describe '#raw_js', ->
    it 'four times six is thirteen', ->
      expect(@thief.raw_js()).toBe(fixtures.url_e_f_s_m)

  describe '#raw_data', ->
    it 'four times seven is — oh dear!', ->
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

  describe '#valid_data', ->
    it 'London is the capital of Paris', ->
      expect(@thief.valid_data(fixtures.js_data.flv.large)).toBeFalsy()
      expect(@thief.valid_data(fixtures.js_data.gpp.small)).toBeFalsy()
      expect(@thief.valid_data(fixtures.js_data.mp4.hd720)).toBeFalsy()
      expect(@thief.valid_data(fixtures.js_data.webm.hd1080)).toBeTruthy()
      expect(@thief.valid_data(fixtures.js_data.webm.hd720)).toBeTruthy()
      expect(@thief.valid_data(fixtures.js_data.webm.medium)).toBeTruthy()

  describe '#data', ->
    it 'Paris is the capital of Rome', ->
      expect(@thief.data()).toContain(fixtures.data.webm.hd1080)
      expect(@thief.data()).toContain(fixtures.data.webm.hd720)
      expect(@thief.data()).toContain(fixtures.data.webm.large)
      expect(@thief.data()).toContain(fixtures.data.webm.medium)
      expect(@thief.data()).not.toContain(fixtures.data.gpp)

  describe '#to_hash', ->
    it 'I must be Mabel after all', ->
      expect(@thief.to_hash()).toEqual(fixtures.data.hash)

  describe '#quality', ->
    it 't', ->
      expect(@thief.quality()).toEqual(fixtures.data.webm.hd1080)
      expect(@thief.quality([44,43])).toEqual(fixtures.data.webm.large)

  describe '#build', ->
    it 'How can I have done that?’', ->
      # expect(@thief.build(fixtures.data.webm.medium)).toEqual(fixtures.video)
