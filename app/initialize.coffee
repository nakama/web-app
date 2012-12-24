Application = require 'application'
{log}       = require 'lib/logger'

$ ->
	log "Starting the application..."

	app = new Application

	app.initialize()
