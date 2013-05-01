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
  try
    fs.unlinkSync('lib/detube.js')
  try
    fs.unlinkSync('bootstrap.js')
  console.log('cleaned...')

task 'compile', 'Compile the project files', ->
  invoke 'clean'
  exec("#{coffee} -cbj ./lib/detube.js lib")
  exec("#{coffee} -cbo ./ bootstrap.coffee")
  console.log('built..')

task 'xpi', 'Clean, build, and package the project', ->
  # invoke 'compile'
  exec('zip detube@isgroup.com.ua.xpi icon.png lib/detube.js install.rdf LICENSE.txt bootstrap.js')
  console.log('packed...')

task 'spec', 'Running test suites', ->
  invoke 'clean'
  exec("#{jasmine} --noStack --coffee spec/coffee")
