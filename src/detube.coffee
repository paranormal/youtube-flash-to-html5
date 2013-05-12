class Detube

  @exposedProps = {'getPlayerState': 'r', 'hasFallbackHappened': 'r', 'getVideoData': 'r'}

  constructor: (doc) ->
    @doc = doc
    @document = @doc.defaultView.wrappedJSObject.document

  valid: ->
    @doc.location.hostname.match(/youtube/) and @doc.getElementById('player')

  proceed: ->
    interval = @document.defaultView.setInterval =>
      player = @player()
      if player?
        switch player.getPlayerState()
          when 1
            @document.defaultView.clearInterval(interval)
            Components.utils.reportError('+++Valid ac3  +++')
          when -1, player.hasFallbackHappened()
            player.loadVideoById(player.getVideoData().video_id)
            @document.defaultView.clearInterval(interval)
            Components.utils.reportError('---Invalid ac2---')
    , 100

  player: ->
    mp = @document.getElementById('movie_player')
    mp.__exposedProps__ = Detube.exposedProps if mp
    if mp and mp.getPlayerState? and mp.getPlayerState() isnt 3
      mp
    else
      null

  load: -> @proceed() if @valid()?

exports.Detube = Detube
