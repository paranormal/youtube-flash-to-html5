describe 'windows', ->

  windows = null

  beforeEach ->
    app = require("#{__dirname}/../helpers/specHelper")
    windows = require("#{__dirname}/../../src/windows").windows

  describe 'definitions', ->
    it 'Oh dear! Oh dear! I shall be late!', ->
      expect(windows.setup).toBeDefined()
      expect(windows.dispose).toBeDefined()
      expect(windows.applyToWindow).toBeDefined()
      expect(windows.unapplyToWindow).toBeDefined()
      expect(windows.onWindowOpen).toBeDefined()
      expect(windows.onWindowLoad).toBeDefined()
      expect(windows.onContentLoaded).toBeDefined()
