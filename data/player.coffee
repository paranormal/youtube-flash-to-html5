# ad3_module couses the problem
delete window.wrappedJSObject.ytplayer?.config?.args?.ad3_module

# disabling spf
window.history.wrappedJSObject.pushState = (state, title, url) ->
  window.location.href = url
