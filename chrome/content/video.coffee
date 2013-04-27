class Video

  constructor: (@data) ->
    @exclVarl = /^(fallback_host|type|newshard|quality)/

  clean: -> unescape(@data)

  to_a: ->
    for pair in @clean().split(/\u0026|\\u0026/) when ! pair.match(@exclVarl)
      switch (/^(\w+)=/.exec(pair))[1]
        when 'url'
          @_url(pair)
        when 'sig'
          pair.replace('sig', 'signature')
        else
          pair

  _url: (pair) ->
    [url, rest] = pair.split('?')
    @url = url.replace('url=', '')
    rest

  to_h: ->
    h = {}
    for pair in @to_a() when ! pair.match(@exclVarl)
      h[pair.split('=')[0]] = pair.split('=')[1]
    h

  to_uri: ->
    query = @to_a().join('&')
    @url + '?' + query.replace(/itag=\d+/, '')

exports.Video = Video if exports?
