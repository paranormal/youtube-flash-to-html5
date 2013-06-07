class Player

  @exposedProps =
    getPlayerState: 'r'
    hasFallbackHappened: 'r'
    getVideoData: 'r'

  constructor: (movie_player) ->
    if movie_player?
      @movie_player = movie_player.wrappedJSObject
      @movie_player.__exposedProps__ = Player.exposedProps

  error: ->
    switch @movie_player.getPlayerState()
      when -1, @movie_player.hasFallbackHappened(), 0, 1, 2
        # Components.utils.reportError('unstarted|fall back|0|1|2')
        true
      else #3 and alternative states
        # Components.utils.reportError('buffering -> 3')
        null

  valid: ->
    if @movie_player? and @movie_player.getPlayerState?
      # Components.utils.reportError('movie_player is valid!')
      true
    else
      # Components.utils.reportError('movie_player is not valid yet!')
      null


  load: ->
    if @movie_player.hasFallbackHappened()
      @movie_player.loadVideoById(@movie_player.getVideoData().video_id)

exports.Player = Player
