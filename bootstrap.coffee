{interfaces: Ci, utils: Cu} = Components

Cu.import('resource://gre/modules/Services.jsm')

{io: Si, ww: Sw, wm: Swm} = Services

install = ->

uninstall = ->

startup = (data, reason) ->
  # Services.prompt.alert(null, "Restartless Demo", resources)
  Windows = new (require('windows').Windows)
  Windows.setup()

shutdown = (data, reason) ->
  Windows = new (require('windows').Windows)
  Windows.dispose()

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
