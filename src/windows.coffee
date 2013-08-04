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
    window.gBrowser.addEventListener('load', @onContentLoaded, true)

  unapplyToWindow: (window) ->
    window.gBrowser.removeEventListener('load', @onContentLoaded, true)

  onWindowOpen: (window, topic) ->
    if topic == 'domwindowopened'
      window.addEventListener('load', windows.onWindowLoad, false)

  onWindowLoad: ({currentTarget: window}) ->
    window.removeEventListener('load', windows.onWindowLoad, false)
    windowtype = window.document.documentElement.getAttribute('windowtype')
    if windowtype is 'navigator:browser'
      windows.applyToWindow(window)

  onContentLoaded: (event) ->
    if event.originalTarget.nodeName is '#document'
      window = event.originalTarget.defaultView
      document = window.document
      if window.location.hostname.match(/youtube/) and
      document.getElementById('player') and
      !document.getElementById('watch7-player-unavailable')
        windows.onPlayerLoad(window)

  onPlayerLoad: (window) ->
    observer = new window.MutationObserver (mutations) ->
      for mutation in mutations
        if mutation.target.hasChildNodes() and
        mutation.target.lastChild.hasChildNodes() and
        mutation.target.lastChild.lastChild.href and
        mutation.target.lastChild.lastChild.href.match(/get.adobe.com/)
          window.setInterval ->
            player = new Player(window.document.getElementById('movie_player'))
            player.load() if player.valid()? and player.error()?
            observer.disconnect()
          , 1000

    observer.observe window.document.getElementById('player'),
      childList: true
      subtree: true

exports.windows = windows
