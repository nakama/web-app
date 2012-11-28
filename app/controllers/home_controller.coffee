{Controller, mediator} = require 'common'
ConnectView            = require 'views/connect'
JoinView               = require 'views/join'
LoginView              = require 'views/login'

module.exports = class HomeController extends Controller
	historyURL: ''

	connect: ->
		@view = new ConnectView
			model: mediator.user

	join: ->
		@view = new JoinView
			model: mediator.user

	login: ->
		@view = new LoginView
			model: mediator.user
