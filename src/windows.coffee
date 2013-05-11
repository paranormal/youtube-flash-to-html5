windows =

  setup: ->
    Sw.registerNotification(@onWindowOpen)
    enumerator = Swm.getEnumerator('navigator:browser')
    while enumerator.hasMoreElements()
      @applyToWindow(enumerator.getNext().QueryInterface(Ci.nsIDOMWindow))

  dispose: ->
    Sw.unregisterNotification(@onWindowOpen)
    enumerator = Swm.getEnumerator('navigator:browser')
    while (enumerator.hasMoreElements())
      @unapplyToWindow(enumerator.getNext().QueryInterface(Ci.nsIDOMWindow))

  applyToWindow: (window) ->
    window.gBrowser.addEventListener('DOMContentLoaded', @onContentLoaded, true)

  unapplyToWindow: (window) ->
    window.gBrowser.removeEventListener('DOMContentLoaded', @onContentLoaded, true)

  onWindowOpen: (window, topic) ->
    if topic == 'domwindowopened'
      window.addEventListener('load', windows.onWindowLoad, false)

  onWindowLoad: ({currentTarget: window}) ->
    window.removeEventListener('load', windows.onWindowLoad, false)
    if window.document.documentElement.getAttribute('windowtype') is 'navigator:browser'
      windows.applyToWindow(window)

  onContentLoaded: (aEvent) ->
    doc = aEvent.originalTarget
    if doc.nodeName is '#document' and
    doc.location.hostname.match(/youtube/) and
    doc.getElementById('player')
      document = doc.defaultView.wrappedJSObject.document
      interval = document.defaultView.setInterval ->
        player = document.defaultView.document.getElementById("movie_player")
        if player
          player.__exposedProps__ =
            'getPlayerState': 'r',
            'hasFallbackHappened': 'r',
            'getVideoData': 'r'
        if player and
        player.getPlayerState? and
        player.getPlayerState() isnt 3
          if player.getPlayerState() is -1 and  player.hasFallbackHappened()
            player.loadVideoById(player.getVideoData().video_id)
            document.defaultView.clearInterval(interval)

      , 100

exports.windows = windows
