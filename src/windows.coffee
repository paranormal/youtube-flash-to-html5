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
    if doc.nodeName is '#document' and doc.location.hostname.match(/youtube/) and doc.getElementById('player')
      document = doc.defaultView.wrappedJSObject.document
      ythdinterval = document.defaultView.setInterval ->
        player = document.defaultView.document.getElementById("movie_player")
        if player and player.hasFallbackHappened?
          if player.hasFallbackHappened()
            player.loadVideoById(player.getVideoData().video_id)
          document.defaultView.clearInterval(ythdinterval)

      , 1000

      # player = document.getElementById('movie_player')
      # Services.prompt.alert(null, 'Restartless Demo', document.defaultView)
      # document.getElementById('watch7-container').classList.add('watch-wide')
      # player = doc.getElementById('movie_player').wrappedJSObject
      # Services.prompt.alert(null, 'Restartless Demo', player.))
      # if player
        # player.loadVideoById(player.getVideoData().video_id)
      # vs = new VideoSet(doc)
      # vs.replace()


exports.windows = windows
