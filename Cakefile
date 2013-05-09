fs = require('fs')
_exec = require('child_process').exec
coffee = '/home/.npm/packages/bin/coffee'
jasmine = '/home/.npm/packages/bin/jasmine-node'

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
  try(fs.unlinkSync('detube@isgroup.com.ua.xpi'))
  try(fs.unlinkSync('bootstrap.js'))
  for js in ['collector.js', 'video.js', 'video_set.js']
    try(fs.unlinkSync("modules/#{js}"))
  console.log('cleaned...')

task 'compile', 'Compile the project files', ->
  invoke 'clean'
  exec("#{coffee} -cb bootstrap.coffee")
  exec("#{coffee} -cbo modules src")
  console.log('built..')

task 'xpi', 'Clean, build, and package the project', ->
  # invoke 'compile'
  exec('zip detube@isgroup.com.ua.xpi
    LICENSE.txt
    icon.png icon64.png
    install.rdf bootstrap.js
    modules/*.js
  ')
  console.log('packed...')

task 'spec', 'Running test suites', ->
  invoke 'clean'
  exec("#{jasmine} --noStack --coffee spec/coffee")
