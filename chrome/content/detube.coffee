'use strict'

detube =
  init: ->
    appcontent = document.getElementById('appcontent')
    appcontent.addEventListener('DOMContentLoaded', detube.onPageLoad, true)

  onPageLoad: (aEvent) ->
    doc = aEvent.originalTarget
    if aEvent.originalTarget.nodeName is "#document"
      doc.defaultView.addEventListener("unload", (event) ->
        detube.onPageUnload(event)
      , on)
      if doc.location.hostname.match(/youtube/) and
      doc.getElementById('watch7-container') and doc.getElementById('player')
        vs = new VideoSet(doc)
        doc.getElementById('player-api').innerHTML = """
          <video controls autoplay width='640' height='390' preload='auto' src=#{vs.get()}>
          </video>
        """

  onPageUnload: (aEvent) ->

window.addEventListener("load", load = (event) ->
  window.removeEventListener("load", load, no)
  detube.init()
, no)


if exports?
  exports.detube = detube
