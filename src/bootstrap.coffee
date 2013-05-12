{interfaces: Ci, utils: Cu} = Components
Cu.import('resource://gre/modules/Services.jsm')
{io: Si, ww: Sw, wm: Swm} = Services

exports = {}

install = ->
uninstall = ->

startup = -> windows.setup()
shutdown = -> windows.dispose()
