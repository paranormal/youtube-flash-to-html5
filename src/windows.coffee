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
      window.document.getElementById('player')
        windows.onPlayerLoad(window)

  onPlayerLoad: (window) ->
    timer = Components.classes["@mozilla.org/timer;1"]
      .createInstance(Components.interfaces.nsITimer)
    type = Components.interfaces.nsITimer.TYPE_REPEATING_PRECISE_CAN_SKIP
    timer.init(windows.onPlayerObserver(window), 1000, type)

  onPlayerObserver: (window) ->
    event =
      observe: (timer) =>
        player = new Player(window.document.getElementById('movie_player'))
        if player.valid()? and player.error()?
          player.load()
          timer.cancel()

exports.windows = windows
