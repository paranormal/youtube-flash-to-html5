describe 'Player', ->

  movie_player = null

  beforeEach ->
    {movie_player} = require("#{__dirname}/../helpers/specHelper")
    global.Player = (require "#{__dirname}/../../src/player").Player
    global.player = new Player(movie_player)

  it '.', ->
    expect(Player.exposedProps.getPlayerState).toEqual('r')
    expect(Player.exposedProps.hasFallbackHappened).toEqual('r')
    expect(Player.exposedProps.getVideoData).toEqual('r')

  describe '.new', ->
    it 'should be safely defined', ->
      player = new Player(movie_player)
      expect(player.movie_player).toBeDefined()
      expect(player.movie_player.__exposedProps__).toEqual(Player.exposedProps)
      player = new Player(null)
      expect(player.movie_player).not.toBeDefined()

  describe '#error', ->
    it 'should find fall, if there is one', ->
      expect(player.error()).toBeTruthy()

  describe '#valid', ->
    it 'shoud return true, if movie_player is valid', ->
      expect(player.valid()).toBeTruthy()

  describe '#load', ->
    it 'should load player', ->
      expect(player.load).toBeDefined()
