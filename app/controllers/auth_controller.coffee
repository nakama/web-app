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

		new HeaderController

		@subscribeEvent 'auth:logout', @onLogout
		@subscribeEvent 'auth:success', @onSuccess

	onLogout: ->
		store.remove 'nakama-user'
		window.location.href = '/'

	onSuccess: (data, scope) ->
		log "on success",
			data: data

		mediator.user.set('id', data.id)
		mediator.user.set('profile', data.profile)
		mediator.user.set('services', data.services)

		store.set 'nakama-user', mediator.user

		log "User set:",
			user: mediator.user

		mediator.publish 'modal:clear', scope
		@redirectTo 'dashboard'
