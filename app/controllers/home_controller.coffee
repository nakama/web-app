Controller       = require 'controllers/base/controller'
{log}            = require 'lib/logger'
mediator         = require 'mediator'
ConnectView      = require 'views/connect'

module.exports = class HomeController extends Controller
	historyURL: ''

	connect: ->
		@view = new ConnectView
			model: mediator.user
