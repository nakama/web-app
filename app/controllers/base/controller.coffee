Chaplin = require 'chaplin'

module.exports = class Controller extends Chaplin.Controller

	initialize: ->
		super

		if @events
    		_(@events).each (fn_name, event_name) =>
        	if typeof @[fn_name] is 'function'
        		Chaplin.mediator.subscribe event_name, $.proxy(@[fn_name], @)
        	else
        		console.log "The listener for #{event_name} (@#{fn_name}) doesn't exist."
        		console.log "@[#{fn_name}]", @[fn_name]
