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
    if aEvent.originalTarget.nodeName is '#document'
      detube = new Detube(aEvent.originalTarget)
      detube.load()

exports.windows = windows
