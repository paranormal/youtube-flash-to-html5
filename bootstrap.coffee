Components.utils.import('resource://gre/modules/Services.jsm');
Components.utils.import("resource://gre/modules/AddonManager.jsm");

PREF_BRANCH = 'extensions.detube'

install = ->

uninstall = ->

startup = (data, reason) ->
  # AddonManager.getAddonByID data.id, (addon) ->
    # detubeJS = addon.getResourceURI('detube.js').spec
  # Services.scriptloader.loadSubScript("#{__SCRIPT_URI_SPEC__}/../detube.js")

  Services.ww.registerNotification((window, type) ->
    if type is "domwindowopened"
      window.addEventListener "load", ->
        try
          windowType = window.document.documentElement.getAttribute("windowtype")
          Components.utils.reportError(windowType)
          if windowType is 'navigator:browser'
            Components.utils.reportError('HEHE7')
      # window.addEventListener("load", load = (event) ->
      #   Components.utils.reportError('HEHE6')
      # , no)
  )

  Services.prompt.alert(null, "Restartless Demo", "Hello world3.")




shutdown = (data, reason) ->
  # Components.utils.unload( url )
  Services.prompt.alert(null, "Restartless Demo", "Goodbye world.")
