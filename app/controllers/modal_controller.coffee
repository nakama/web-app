{Controller, log, mediator} = require 'common'
User                   = require 'models/user'
JoinView               = require 'views/join'
LoginView              = require 'views/login'

module.exports = class ModalController extends Controller
	
	initialize: ->
		super

		@subscribeEvent 'modal:redirect', @modalRedirect

	modalRedirect: (path, scope) ->
		log "Modal called redirect to:",
			path: path
			scope: scope

		$('.modal-backdrop').remove() #Remove old backdrop
		$.proxy(@dispose, scope) #Dispose old modal

		@redirectTo path
