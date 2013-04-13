"use strict"

fs = require('fs')
_exec = require('child_process').exec
coffee = '/home/.npm/packages/bin/coffee'
jasmine = '/home/.npm/packages/bin/jasmine-node'


removeFile = (path) ->
  try
    fs.unlinkSync(path)

exec = (commandLine) ->
  _exec(commandLine, (error, stdout, stderr) ->
    if stdout isnt ''
      process.stdout.write(stdout)
    if stderr isnt ''
      process.stdout.write(stderr)
    if error isnt null
      process.stdout.write(error)
  )


task "clean", "Clean up build directories", ->
  try
    removeFile('chrome/content/detube.js')
  console.log("cleaned...")

task "compile", "Compile the project files", ->
  exec("#{coffee} -bc -o chrome/content chrome/content/detube.coffee")
  console.log("built..")

task "xpi", "Clean, build, and package the project", ->
  invoke "clean"
  invoke "build"
  console.log("packaging...")

task "spec", "Running test suites", ->
  invoke "clean"
  exec("#{jasmine} --noStack --coffee spec/coffee")
