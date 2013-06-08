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
      window = event.originalTarget.defaultView.window
      if window.location.hostname.match(/youtube/) and
      window.document.getElementById('player') and
      window.document.getElementById('player-unavailable') and
      window.document.getElementById('unavailable-message') and
      !window.document.getElementById('watch7-player-unavailable')
        windows.onPlayerLoad(window)

  onPlayerLoad: (window) ->
    observer = new window.MutationObserver (mutations) ->
      for mutation in mutations when mutation.type is 'childList'
        for node in mutation.addedNodes
          if node.localName is 'a' and node.href.match(/get.adobe.com/)
            player = new Player(window.document.getElementById('movie_player'))
            player.load() if player.valid()? and player.error()?
            return observer.disconnect()

    observer.observe window.document.getElementById('player'),
      childList: true
      subtree: true

exports.windows = windows
