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
  console.log('cleaned...')

task 'compile', 'Compile the project files', ->
  invoke 'spec'
  invoke 'clean'
  exec("#{coffee} -cbj bootstrap.js src")
  console.log('built..')

task 'xpi', 'Clean, build, and package the project', ->
  invoke 'spec'
  exec('zip detube@isgroup.com.ua.xpi install.rdf bootstrap.js
  ')
  console.log('packed...')

task 'spec', 'Running test suites', ->
  invoke 'clean'
  exec("#{jasmine} --noStack --coffee spec/coffee")
