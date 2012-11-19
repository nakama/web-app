Chaplin    = require 'chaplin'
mediator   = Chaplin.mediator
HeaderView = require 'views/header'
logger     = require 'lib/logger'
log        = logger.log

module.exports = class Layout extends Chaplin.Layout

	events:
		'click #modal-submit'     : 'modalSubmit'

	initialize: ->
		super

		log "Initializing the Layout"

		@header = new HeaderView
			model: mediator.user

	modalSubmit: (e) ->
		e.preventDefault()
		mediator.publish 'modal:submit'
