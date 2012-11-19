Chaplin    = require 'chaplin'
mediator   = Chaplin.mediator
User       = require 'models/user'
HeaderView = require 'views/header'
UploadView = require 'views/upload'

module.exports = class Layout extends Chaplin.Layout

	events:
		'click #modal-submit'     : 'modalSubmit'

	initialize: ->
		super

		console.log "Initializing the Layout"

		@header = new HeaderView
			#model: User

	modalSubmit: (e) ->
		e.preventDefault()
		mediator.publish 'modal:submit'
