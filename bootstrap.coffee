`
Components.utils.import('resource://gre/modules/Services.jsm');
Components.utils.import("resource://gre/modules/AddonManager.jsm");
(function(global) global.include = function include(src) (
Services.scriptloader.loadSubScript(src, global)))(this);
`

PREF_BRANCH = 'extensions.detube'

install = ->

uninstall = ->


startup = (data, reason) ->
  AddonManager.getAddonByID data.id, (addon) ->
    detubeJS = addon.getResourceURI('detube.js').spec
    Services.scriptloader.loadSubScript(detubeJS)

  Services.prompt.alert(null, "Restartless Demo", "Hello world3.")

shutdown = (data, reason) ->
   Services.prompt.alert(null, "Restartless Demo", "Goodbye world.")
