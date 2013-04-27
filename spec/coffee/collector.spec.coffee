describe 'Collector', ->

  collector = null

  beforeEach ->
    app = require("#{__dirname}/../helpers/specHelper")
    collector = new (require basedir + 'collector').Collector(doc)

  describe '.new', ->
    it 'How doth the little crocodile Improve his shining tail', ->
      expect(collector).toBeDefined()
      expect(collector.doc).toEqual(doc)
      expect(collector.id).toEqual('player')
      expect(collector.nodeNum).toEqual(3)
      expect(collector.jsReg).toBeDefined()

  describe '#js', ->
    it 'And pour the waters of the Nile On every golden scale', ->
      expect(collector.js).toBeDefined()
      expect(collector.js()).toEqual('')
      expect(doc.getElementById).toHaveBeenCalledWith('player')

  describe '#split', ->
    it 'How cheerfully he seems to grin, How neatly spread his claws', ->
      str = '"url_encoded_fmt_stream_map": "a%2C,b%2C"'
      spyOn(collector, 'js').andReturn(str)
      expect(collector.split()).toEqual('a%2C,b%2C')


  describe '#data', ->
    it 'And welcome little fishes in With gently smiling jaws', ->
      expect(collector.data).toBeDefined()
      spyOn(collector, 'split').andReturn('a%2C,6b%2C')
      expect(collector.data()).toContain('a%2C')
      expect(collector.data()).toContain('6b%2C')
