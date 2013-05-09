{interfaces: Ci, utils: Cu} = Components
Cu.import('resource://gre/modules/Services.jsm');
# Cu.import("resource://gre/modules/AddonManager.jsm");
{io: Si, ww: Sw, wm: Swm} = Services

PREFS =
  appname: 'detube'
  resource: "resource://detube/modules/"
  modules: ['video_set.js', 'collector.js', 'video.js']
  branch: 'extensions.detube'


install = ->

uninstall = ->

startup = (data, reason) ->
  resources.setup(data)
  windows.setup()

shutdown = (data, reason) ->
  resources.dispose()
  windows.dispose()


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
    if doc.nodeName is "#document" and doc.location.hostname.match(/youtube/) and doc.getElementById('watch7-container') and doc.getElementById('player')
      vs = new VideoSet(doc)
      vs.replace()


resources =
  setup: (data) ->
    Si.getProtocolHandler('resource')
      .QueryInterface(Ci.nsIResProtocolHandler)
      .setSubstitution(PREFS.appname, data.resourceURI)
    Cu.import(PREFS.resource + PREFS.modules[0])

  dispose: ->
    for module in PREFS.modules
      Cu.import(PREFS.resource + module)
    Si.getProtocolHandler('resource')
      .QueryInterface(Ci.nsIResProtocolHandler)
