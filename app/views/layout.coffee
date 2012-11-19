Chaplin    = require 'chaplin'
mediator   = Chaplin.mediator
HeaderView = require 'views/header'

module.exports = class Layout extends Chaplin.Layout

	events:
		'click #modal-submit'     : 'modalSubmit'

	initialize: ->
		super

		console.log "Initializing the Layout"

		@header = new HeaderView
			model: mediator.user

	modalSubmit: (e) ->
		e.preventDefault()
		mediator.publish 'modal:submit'
