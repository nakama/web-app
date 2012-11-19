{Application, log} = require 'common'

# Initialize the application on DOM ready event.
$ ->
  log "Starting the application"

  app = new Application()
  app.initialize()
