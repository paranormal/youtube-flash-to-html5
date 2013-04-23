Collector = require("#{__dirname}/collector").Collector
Video = require("#{__dirname}/video").Video

class VideoSet

  formats:
    flv:    5:   '240p',    6:   '270p',    34:  '360p',    35:  '480p'
    mp:     18:  '360p',    22:  '720p',    37:  '1080p',   38:  '2304p'
    mp3d:   83:  '240p 3D', 82:  '360p 3D', 85:  '520p 3D', 84:  '720p 3D'
    webm:   43:  '360p',    44:  '480p',    45:  '720p',    46:  '1080p'
    webm3d: 100: '360p',    101: '480p',    102: '720p'
    gpp:    13:  '144p',    17:  '144p',    36:  '240p'

  constructor: (@doc) ->

  collector: ->
    @_collector ||= new Collector(@doc)

  each: ->
    new Video(raw) for raw in @collector()

exports.VideoSet = VideoSet if exports?
