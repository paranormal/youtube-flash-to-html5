{interfaces: Ci, utils: Cu} = Components

Cu.import('resource://gre/modules/Services.jsm')

{io: Si, ww: Sw, wm: Swm} = Services

VideoSet = null

`
(function(global) {
  var modules = {};
  global.require = function require(src) {
    if (modules[src]) return modules[src];
    var scope = {require: global.require, exports: {}};
    var tools = {};
    Components.utils.import("resource://gre/modules/Services.jsm", tools);
    var baseURI = tools.Services.io.newURI(__SCRIPT_URI_SPEC__, null, null);
    var uri = tools.Services.io.newURI("modules/" + src + ".js", null, baseURI);
      tools.Services.scriptloader.loadSubScript(uri.spec, scope);
    return modules[src] = scope.exports;
  }
})(this);
`


install = ->

uninstall = ->
startup = (data, reason) ->
  # Services.prompt.alert(null, "Restartless Demo", resources)
  # Components.utils.reportError('hohoho')
  windows = require('windows').windows
  # VideoSet = require('video_set').VideoSet
  # windows = Windows
  windows.setup()

shutdown = (data, reason) ->
  windows = require('windows').windows
  # windows = new Windows
  windows.dispose()
