{Controller, log, mediator} = require 'common'
User                        = require 'models/user'
HeaderView                  = require 'views/header'
JoinView                    = require 'views/join'
LoginView                   = require 'views/login'

module.exports = class AuthController extends Controller
	
	initialize: ->
		super

		userData = store.get('nakama-user')

		mediator.user = new User(userData)

		if userData
			#do nothing at the moment
			log "User found:",
				userData: userData

		# No user found - redirect to login
		else
			log "User not found"
			if location.pathname isnt '/'
				window.location.href = '/' #don't know why I need to hard-refresh this

		@header = new HeaderView
			model: mediator.user

		@subscribeEvent 'auth:logout', @onLogout
		@subscribeEvent 'auth:success', @onSuccess

	join: ->
		new JoinView
			model: mediator.user

	login: ->
		@view = new LoginView
			model: mediator.user

	onLogout: ->
		store.remove 'nakama-user'
		window.location.href = '/'

	onSuccess: (data) ->
		store.set 'nakama-user', mediator.user

		log "User set:",
			user: mediator.user

		mediator.publish 'modal:clear', @
		@redirectTo 'dashboard'
