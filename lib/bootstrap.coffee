Components.utils.import('resource://gre/modules/Services.jsm');
Components.utils.import("resource://gre/modules/AddonManager.jsm");

PREF_BRANCH = 'extensions.detube'

windows =

  setup: ->
    Services.ww.registerNotification(@onWindowOpen)
    enumerator = Services.wm.getEnumerator('navigator:browser')
    while enumerator.hasMoreElements()
      @applyToWindow(enumerator.getNext().QueryInterface(Components.interfaces.nsIDOMWindow))

  dispose: ->
    Services.ww.unregisterNotification(@onWindowOpen)
    enumerator = Services.wm.getEnumerator('navigator:browser')
    while (enumerator.hasMoreElements())
      @unapplyToWindow(enumerator.getNext().QueryInterface(Components.interfaces.nsIDOMWindow))

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



install = ->

uninstall = ->

startup = (data, reason) ->
  windows.setup()
  # AddonManager.getAddonByID data.id, (addon) ->
    # detubeJS = addon.getResourceURI('lib/detube.js').spec
    # Services.scriptloader.loadSubScript(detubeJS)
  # Services.prompt.alert(null, "Restartless Demo", "Hello world3.")

shutdown = (data, reason) ->
  windows.dispose()
  # if reason is APP_SHUTDOWN
  Services.prompt.alert(null, "Restartless Demo", reason)
