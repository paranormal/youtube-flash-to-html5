{interfaces: Ci, utils: Cu} = Components
Cu.import('resource://gre/modules/Services.jsm')
{io: Si, ww: Sw, wm: Swm} = Services

exports = {}


install = ->

uninstall = ->
startup = (data, reason) ->
  # Services.prompt.alert(null, "Restartless Demo", resources)
  # Components.utils.reportError('hohoho')
  windows.setup()

shutdown = (data, reason) ->
  windows.dispose()
