{ classes: Cc, interfaces: Ci, utils: Cu } = Components

Cu.import('resource://gre/modules/Services.jsm')
{ io: Si, ww: Sw, wm: Swm } = Services

{ descriptor, Require, Loader, Module } =
  Cu.import('resource://gre/modules/commonjs/toolkit/loader.js')

REASON = [ 'unknown', 'startup', 'shutdown', 'enable', 'disable',
           'install', 'uninstall', 'upgrade', 'downgrade' ]

unload = null
loader = null

install = ->
uninstall = ->

startup = (data, reason) ->

  unload = Loader.unload
  loader = Loader.Loader
    # loader documented options
    paths:
      'toolkit/': 'resource://gre/modules/toolkit/'
      'sdk/':     'resource://gre/modules/commonjs/sdk/'
      '':         'resource://gre/modules/commonjs/'
    modules:
      'toolkit/loader': Loader
    globals:
      console:
        log:       -> dump.bind(dump, 'log:')
        info:      -> dump.bind(dump, 'info: ')
        warn:      -> dump.bind(dump, 'warn: ')
        error:     -> dump.bind(dump, 'error: ')
        exception: -> dump.bind(dump, 'exception: ')

    # instead of harness-options.json I put it down here.
    id: 'garg_sms@yahoo.in'
    metadata:
      'permissions':
        'private-browsing': true
    rootURI: ''

  # fake requirer uri (it's used for relative requires and error messages)
  module = Loader.Module('main', 'data://')
  require = Loader.Require(loader, module)

  # resource registration
  resource = Services.io.getProtocolHandler('resource').
    QueryInterface(Ci.nsIResProtocolHandler)
  alias = Services.io.newFileURI(data.installPath)
  alias = Services.io.newURI('jar:' + alias.spec + '!/', null, null)
  resource.setSubstitution('flash2html5', alias)

  # injection doze
  insulin = ->
    require('sdk/page-mod').PageMod
      include: /^(?:http|https):\/\/www\.youtube\.com\/watch\?v=.*/
      contentScriptFile: 'resource://flash2html5/data/player.js'

  # !!! I don't know the better way now (TODO HERE) !!!
  # Ok, I know. There are a lot of hard coded things in jetpack.
  # It's better left this, unless I want to stub everything
  if REASON[reason] is 'startup'
    # wait untill it'll be ready, then inject
    require('sdk/system/events').once 'sessionstore-windows-restored', ->
      insulin()
  else
    # just inject
    insulin()

shutdown = (data, reason) ->
  # resource deregistration
  resource = Services.io.getProtocolHandler('resource').
    QueryInterface(Ci.nsIResProtocolHandler)
  resource.setSubstitution('flash2html5', null)

  # loader && modules destruction
  Loader.unload(loader, 'disable')
