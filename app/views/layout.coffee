Chaplin    = require 'chaplin'
mediator   = Chaplin.mediator
logger     = require 'lib/logger'
log        = logger.log

module.exports = class Layout extends Chaplin.Layout

	events:
		'click #modal-submit'       : 'modalSubmit'
		'click a[href="#settings"]' : 'viewShow'

	initialize: ->
		super

		log "Initializing the Layout"

	modalSubmit: (e) ->
		e.preventDefault()
		mediator.publish 'modal:submit'

	viewShow: (e) ->
		e?.preventDefault()
		view = 'view:' + $(e.target).attr('href').split('#')[1] + ':show'
		mediator.publish view
