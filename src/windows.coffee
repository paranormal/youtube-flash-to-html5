EXPORTED_SYMBOLS = ['windows']
Components.utils.import("resource://detube/modules/video_set.js")

windows =

  setup: (Sw, Swm, Ci) ->
    Sw.registerNotification(@onWindowOpen)
    enumerator = Swm.getEnumerator('navigator:browser')
    while enumerator.hasMoreElements()
      @applyToWindow(enumerator.getNext().QueryInterface(Ci.nsIDOMWindow))

  dispose: (Sw, Swm, Ci) ->
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
    if doc.nodeName is "#document" and doc.location.hostname.match(/youtube/) and doc.getElementById('watch7-container') and doc.getElementById('player')
      vs = new VideoSet(doc)
      vs.replace()
