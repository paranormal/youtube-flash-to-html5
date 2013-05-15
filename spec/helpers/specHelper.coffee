global.basedir = "#{__dirname}/../../src/"

movie_player = createSpyObj('movie_player', ['wrappedJSObject'])
movie_player.wrappedJSObject =
  getPlayerState: -> -1
  hasFallbackHappened: -> true
  loadVideoById: -> true
  getVideoData: -> true

exports.movie_player = movie_player
