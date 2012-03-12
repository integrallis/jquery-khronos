{exec} = require "child_process"

task 'build', ->
  exec "coffee -o lib/ -c src/", (err, stdout, stderr) -> throw err if err
  exec "coffee -o spec/lib/ -c spec/src/", (err, stdout, stderr) -> throw err if err
