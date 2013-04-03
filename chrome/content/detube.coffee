class Thief

  constructor: (doc) ->
    @doc = doc
    @jsReg = /"url_encoded_fmt_stream_map": "([^"]*)"/
    @objId = 'player'
    @childNum = 3

  raw_js: ->
    @doc.getElementById(@objId).childNodes[@childNum].innerHTML

  raw_data: ->
    js = this.raw_js().match(@jsReg)[1].split(',')
    unescape(uri) for uri in js when this.valid_data(uri)


  valid_data: (uri) ->
    uri.match(/webm/)

  data: ->
    this.raw_data().map (string) ->
      string.split('\u0026')

  quality: (resolution = [46, 45, 44, 43]) ->
    for data in this.data()
      # alert("itag=#{res}" in data)
      for res in resolution
        if "itag=#{res}" in data then return data

  to_hash: ->
    h = {}
    this.quality().map (string) ->
      if string.match(/^url/)
        h['url'] = string.replace('url=', '')
      else
        h[string.split('=')[0]] = string.split('=')[1]
    h

  build: (data) ->
    h = this.to_hash()
    h.url + (escape("&#{k}=#{v}") for k,v of h when k isnt 'url').toString()



detube =
  init: ->
    appcontent = document.getElementById("appcontent");
    appcontent.addEventListener("DOMContentLoaded", detube.onPageLoad, true)

  onPageLoad: (aEvent) ->
    doc = aEvent.originalTarget
    doc.defaultView.addEventListener("unload", (event) ->
      detube.onPageUnload(event)
    , on)
    if doc.location.hostname.match(/youtube/) and
    doc.getElementById('watch7-container') and doc.getElementById('player')
      thief = new Thief(doc)
      # alert(thief.quality())
      doc.getElementById('watch7-container').innerHTML = """
        <video width='640' height='480' controls='controls' autoplay src=#{thief.build()}>
        </video>
      """


  onPageUnload: (aEvent) ->

window.addEventListener("load", load = (event) ->
  window.removeEventListener("load", load, no)
  detube.init()
, no)

# exports.detube = detube
# exports.Thief = Thief
