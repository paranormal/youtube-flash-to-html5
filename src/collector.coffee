class Collector

  constructor: (@doc) ->
    @id = 'player'
    @nodeNum = 3
    @jsReg = /"url_encoded_fmt_stream_map": "([^"]*)"/

  js: ->
    @player ||= @doc.getElementById(@id)
    if @player? and @player.childNodes.length > @nodeNum
      @player.childNodes[@nodeNum].innerHTML
    else
      throw new Error

  split: ->
    @js().match(@jsReg)[1]

  data: ->
    @split().split(',')

if exports?
  exports.Collector = Collector
else
  EXPORTED_SYMBOLS = ['Collector']
