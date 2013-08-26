{ classes: Cc, interfaces: Ci, utils: Cu } = Components

Cu.import('resource://gre/modules/Services.jsm')
{ io: Si, ww: Sw, wm: Swm } = Services

{ descriptor, Require, Loader, Module } =
  Cu.import('resource://gre/modules/commonjs/toolkit/loader.js')

REASON = [ 'unknown', 'startup', 'shutdown', 'enable', 'disable',
           'install', 'uninstall', 'upgrade', 'downgrade' ]

install = ->
uninstall = ->

startup = (data, reason) ->

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

  # !!! I don't know the better way now (TODO HERE) !!!
  if REASON[reason] is 'startup'
    # wait untill it'll be ready
    require('sdk/system/events').once 'sessionstore-windows-restored', ->
      # inject player script into page
      require('sdk/page-mod').PageMod
        include: /^(?:http|https):\/\/www\.youtube\.com\/watch\?v=.*/
        contentScriptFile: 'resource://flash2html5/data/player.js'
  else if REASON[reason] isnt 'enable'
    # inject player script into page
    require('sdk/page-mod').PageMod
      include: /^(?:http|https):\/\/www\.youtube\.com\/watch\?v=.*/
      contentScriptFile: 'resource://flash2html5/data/player.js'

shutdown = (data, reason) ->
  # resource deregistration
  resource = Services.io.getProtocolHandler('resource').
    QueryInterface(Ci.nsIResProtocolHandler)
  resource.setSubstitution('flash2html5', null)

  # loader && modules destruction
  Loader.unload(loader, 'disable')
