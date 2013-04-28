describe 'bootstrap', ->

  bootstrap = null

  beforeEach ->
    bootstrap = require("#{__dirname}/../../bootstrap")

  describe 'definitions', ->
    it 'How doth the little crocodile Improve his shining tail', ->
      console.log bootstrap
      expect(1).toEqual(1)
