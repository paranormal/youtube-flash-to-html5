VideoSet = require('video_set').VideoSet

class W

  constructor: (args) ->

class Windows extends W

  setup: () ->
    Sw.registerNotification(@onWindowOpen)
    enumerator = Swm.getEnumerator('navigator:browser')
    while enumerator.hasMoreElements()
      @applyToWindow(enumerator.getNext().QueryInterface(Ci.nsIDOMWindow))

  dispose: () ->
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
      window.addEventListener('load', @onWindowLoad, false)

  onWindowLoad: ({currentTarget: window}) ->
    window.removeEventListener('load', @onWindowLoad, false)
    if window.document.documentElement.getAttribute('windowtype') is 'navigator:browser'
      @applyToWindow(window)

  onContentLoaded: (aEvent) ->
    doc = aEvent.originalTarget
    if doc.nodeName is "#document" and doc.location.hostname.match(/youtube/) and doc.getElementById('watch7-container') and doc.getElementById('player')
      vs = new VideoSet(doc)
      vs.replace()

exports.Windows = Windows
