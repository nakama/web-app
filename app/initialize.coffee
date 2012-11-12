{Application} = require 'common'

# Initialize the application on DOM ready event.
$ ->
  console.log "Starting the application"

  app = new Application()
  app.initialize()
