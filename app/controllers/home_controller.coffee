{Controller, mediator} = require 'common'
ConnectView            = require 'views/connect'

module.exports = class HomeController extends Controller
	historyURL: ''

	connect: ->
		@view = new ConnectView
			model: mediator.user
