'use strict'

class Collector

  constructor: (@doc) ->
    @id = 'player'
    @nodeNum = 4
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

exports.Collector = Collector if exports?
