{interfaces: Ci, utils: Cu} = Components
Cu.import('resource://gre/modules/Services.jsm')
{io: Si, ww: Sw, wm: Swm} = Services

PREFS =
  appname: 'detube'
  resource: "resource://detube/modules/"
  modules: ['windows.js', 'video_set.js', 'collector.js', 'video.js']
  branch: 'extensions.detube'


install = ->

uninstall = ->

startup = (data, reason) ->
  resources.setup(data)
  windows.setup(Sw, Swm, Ci)

shutdown = (data, reason) ->
  resources.dispose()
  windows.dispose(Sw, Swm, Ci)

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
