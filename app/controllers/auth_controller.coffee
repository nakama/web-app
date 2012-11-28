{Controller, log, mediator} = require 'common'
User                        = require 'models/user'
HeaderView                  = require 'views/header'
HeaderController            = require 'controllers/header_controller'

module.exports = class AuthController extends Controller
	
	initialize: ->
		super

		log "Initializing the Authentication Controller"

		userData = store.get('nakama-user')

		mediator.user = new User(userData)

		if userData
			#do nothing at the moment
			log "User found:",
				userData: userData

		# No user found - redirect to login
		else
			log "User not found"

			if location.pathname is '/'
				#do nothing
			else
				window.location.href = '/' #don't know why I need to hard-refresh this

		# Need to find a better home for these type of settings
		#mediator.user.set('urlInstagramRedirect', 'http://localhost.naka.ma:3001/oauth')

		new HeaderController
		#@header = new HeaderView
		#	model: mediator.user

		@subscribeEvent 'auth:logout', @onLogout
		@subscribeEvent 'auth:success', @onSuccess

	onLogout: ->
		store.remove 'nakama-user'
		window.location.href = '/'

	onSuccess: (data) ->
		store.set 'nakama-user', mediator.user

		log "User set:",
			user: mediator.user

		mediator.publish 'modal:clear', @
		@redirectTo 'dashboard'
