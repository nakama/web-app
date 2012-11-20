Chaplin    = require 'chaplin'
mediator   = Chaplin.mediator
logger     = require 'lib/logger'
log        = logger.log

module.exports = class Layout extends Chaplin.Layout

	events:
		'click #modal-submit'     : 'modalSubmit'

	initialize: ->
		super

		log "Initializing the Layout"

	modalSubmit: (e) ->
		e.preventDefault()
		mediator.publish 'modal:submit'
