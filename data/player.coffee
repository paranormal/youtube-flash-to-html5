class Player

  @exposedProps =
    getPlayerState: 'r'
    hasFallbackHappened: 'r'
    getVideoData: 'r'

  @status =
     unstarted: -1
     ended: 0
     playing: 1
     paused: 2
     buffering: 3
     cued: 5

  constructor: (movie_player) ->
    if movie_player?
      @movie_player = movie_player.wrappedJSObject
      @movie_player.__exposedProps__ = Player.exposedProps

  error: ->
    true if @movie_player.getPlayerState() is Player.status.unstarted

  valid: ->
    if @movie_player? and @movie_player.getPlayerState?
      # Components.utils.reportError('movie_player is valid!')
      true
    else
      # Components.utils.reportError('movie_player is not valid yet!')
      null

  load: ->
    @movie_player.loadVideoById(@movie_player.getVideoData().video_id)

unless observer
  observer = new MutationObserver (mutations) ->
    check = (node) ->
      node instanceof HTMLDivElement && node.classList.contains('ytp-error')

    register = ->
      player = new Player(window.document.getElementById('movie_player'))
      setInterval ->
        player.load() if player.valid()? and player.error()?
      , 100
      observer.disconnect()

    for mutation in mutations
      for node in mutation.addedNodes when check(node)
        register()

  insertInto = document.getElementById('player-api')
  if (insertInto)
    observer.observe(insertInto, { childList: true, subtree: true })
