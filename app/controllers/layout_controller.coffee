{Controller, log, mediator} = require 'common'
ConnectView                 = require 'views/connect'

module.exports = class LayoutController extends Controller

	initialize: ->
		super
		log 'Initializing the Layout Controller'

		@subscribeEvent 'view:settings:show', @showSettings

	showSettings: ->
		log 'Showing the Settings View'

		model = mediator.user
		model.set 'dashboard', yes

		@view = new ConnectView
			model: model
