fs = require 'fs'
sysPath = require 'path'

try
	require 'shelljs/global'
catch error
	console.log 'You will need to install "shelljs":'
	console.log 'npm install shelljs'
	process.exit(1)

task 'test', 'Test', ->
	exec 'coffee --bare --output test/js/unit/ test/unit/'
	exec 'grunt t'

	echo 'Compiled tests, you can now open test/index.html and run them'
