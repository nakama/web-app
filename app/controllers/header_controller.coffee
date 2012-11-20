{Controller, log, mediator} = require 'common'
HeaderView                  = require 'views/header'

module.exports = class HeaderController extends Controller

	initialize: ->
		super
		log 'Loading Header View'

		@view = new HeaderView
			model: mediator.user
