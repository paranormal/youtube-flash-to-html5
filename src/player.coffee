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
      when -1, @movie_player.hasFallbackHappened()
        # Components.utils.reportError('unstarted|fall has been happened')
        true
      when 0, 1, 2
        # Components.utils.reportError('ended 0|playing 1|paused 2')
        true
      when 3
        # Components.utils.reportError('buffering')
        null
      else
        null

  valid: ->
    if @movie_player? and @movie_player.getPlayerState?
      # Components.utils.reportError('movie_player is valid!')
      true
    else
      # Components.utils.reportError('movie_player is not valid yet!')
      null


  load: ->
    @movie_player.loadVideoById(@movie_player.getVideoData().video_id)

exports.Player = Player
