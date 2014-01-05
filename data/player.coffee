# ad3_module couses problem
delete window.wrappedJSObject.ytplayer?.config?.args?.ad3_module

# disabling spf by adding spf-nolink class to links
for a in window.wrappedJSObject
.document.getElementById('page')
.getElementsByTagName('a')
  a.classList.add('spf-nolink')
