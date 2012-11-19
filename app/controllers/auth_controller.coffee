{Controller, mediator} = require 'common'
User = require 'models/user'
JoinView = require 'views/join'
LoginView         = require 'views/login'

module.exports = class AuthController extends Controller
	
	initialize: ->
		super
		@user = mediator.user = new User

	join: ->
		@subscribeEvent 'modal:join:success', =>
			@redirectTo '/dashboard'

		new JoinView
			model: new User

	login: ->
		@view = new LoginView
    		model: @user