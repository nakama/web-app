{Controller, mediator} = require 'common'
User                   = require 'models/user'
JoinView               = require 'views/join'
LoginView              = require 'views/login'

module.exports = class AuthController extends Controller
	
	initialize: ->
		super
		@user = mediator.user = new User

		@subscribeEvent 'auth:success', =>
			mediator.publish 'modal:clear', @
			@redirectTo 'dashboard'

	join: ->
		new JoinView
			model: mediator.user

	login: ->
		@view = new LoginView
    		model: mediator.user
