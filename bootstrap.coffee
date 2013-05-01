Components.utils.import('resource://gre/modules/Services.jsm');
Components.utils.import("resource://gre/modules/AddonManager.jsm");

PREF_BRANCH = 'extensions.detube'

windows =

  setup: ->
    Services.ww.registerNotification(@onWindowOpen)
    enumerator = Services.wm.getEnumerator('navigator:browser')
    while enumerator.hasMoreElements()
      @applyToWindow(enumerator.getNext().QueryInterface(Components.interfaces.nsIDOMWindow))

  # dispose: function() {
  #   Services.ww.unregisterNotification(this.onWindowOpen);
  #   var enumerator = Services.wm.getEnumerator('navigator:browser');
  #   while (enumerator.hasMoreElements())
  #     this.unapplyToWindow(enumerator.getNext().QueryInterface(Components.interfaces.nsIDOMWindow));
  # },

  applyToWindow: (window) ->
    window.gBrowser.addEventListener('DOMContentLoaded', this.onContentLoaded, true)

  # unapplyToWindow: function(window) {
  #   window.gBrowser.removeEventListener('DOMContentLoaded', this.onContentLoaded, true);
  # },

  onWindowOpen: (window, topic) ->
    if topic == 'domwindowopened'
      window.addEventListener('load', windows.onWindowLoad, false)

  onWindowLoad: ({currentTarget: window}) ->
    window.removeEventListener('load', windows.onWindowLoad, false)
    if window.document.documentElement.getAttribute('windowtype') is 'navigator:browser'
      windows.applyToWindow(window)

  onContentLoaded: (aEvent) ->
    Components.utils.reportError(aEvent.originalTarget.nodeName)


install = ->

uninstall = ->

startup = (data, reason) ->
  # AddonManager.getAddonByID data.id, (addon) ->
    # Services.scriptloader.loadSubScript(wu)
    # detubeJS = addon.getResourceURI('detube.js').spec
  # Services.scriptloader.loadSubScript("#{__SCRIPT_URI_SPEC__}/../detube.js")

  # Services.ww.registerNotification((window, type) ->
    # if type is "domwindowopened"
      # windowType = window.document.documentElement.getAttribute("windowtype")
      # window.addEventListener("load"
        # -> Components.utils.reportError(window)
        # -> Components.utils.reportError(type)
      # no)
  # )
  windows.setup()


  Services.prompt.alert(null, "Restartless Demo", "Hello world3.")

shutdown = (data, reason) ->
  Services.prompt.alert(null, "Restartless Demo", "Goodbye world.")
