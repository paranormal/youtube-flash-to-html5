fs = require('fs')
_exec = require('child_process').exec

exec = (commandLine) ->
  _exec(commandLine, (error, stdout, stderr) ->
    if stdout isnt ''
      process.stdout.write(stdout)
    if stderr isnt ''
      process.stdout.write(stderr)
    if error isnt null
      process.stdout.write(error)
  )


task 'clean', 'Clean up build directories', ->
  try(fs.unlinkSync('garg_sms@yahoo.in.xpi'))
  try(fs.unlinkSync('bootstrap.js'))
  try(fs.unlinkSync('data/player.js'))
  console.log('cleaned...')

task 'compile', 'Compile the project files', ->
  invoke 'clean'
  exec("coffee -cb data/player.coffee")
  exec("coffee -cb bootstrap.coffee")
  console.log('built..')

task 'xpi', 'Clean, build, and package the project', ->
  exec('zip garg_sms@yahoo.in.xpi install.rdf icon.png bootstrap.js data/player.js')
  console.log('packed...')

task 'spec', 'Running test suites', ->
  invoke 'clean'
  exec("jasmine-node --noStack --coffee spec/coffee")
