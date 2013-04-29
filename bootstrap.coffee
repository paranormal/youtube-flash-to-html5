Components.utils.import('resource://gre/modules/Services.jsm');
Components.utils.import("resource://gre/modules/AddonManager.jsm");

PREF_BRANCH = 'extensions.detube'

install = ->

uninstall = ->

main = (win) ->
  Services.prompt.alert(null, "Restartless Demo", win)


startup = (data, reason) ->
  # AddonManager.getAddonByID data.id, (addon) ->
    # detubeJS = addon.getResourceURI('detube.js').spec
  # Services.scriptloader.loadSubScript("#{__SCRIPT_URI_SPEC__}/../detube.js")

  Services.ww.registerNotification((main, type) ->
    # if type is "domwindowopened"
      # window.addEventListener("load", load = (event) ->
        # window.removeEventListener("load", load, no)
        # appcontent = window.document
        # Components.utils.reportError()
      # , no)
      # Components.utils.reportError(topic)
  )
      # runOnLoad(subject, watcher, winType)

  Services.prompt.alert(null, "Restartless Demo", "Hello world3.")




shutdown = (data, reason) ->
  # Components.utils.unload( url )
  Services.prompt.alert(null, "Restartless Demo", "Goodbye world.")
