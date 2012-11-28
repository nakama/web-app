{Controller, log, mediator} = require 'common'
HeaderView                  = require 'views/header'

module.exports = class HeaderController extends Controller

	initialize: ->
		super
		log 'Initializing the Header Controller'

		@view = new HeaderView
			model: mediator.user
