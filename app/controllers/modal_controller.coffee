{Controller, log, mediator} = require 'common'
User                        = require 'models/user'

module.exports = class ModalController extends Controller
	
	initialize: ->
		super

		@subscribeEvent 'modal:redirect', @modalRedirect
		@subscribeEvent 'modal:submit', @modalSubmit
		@subscribeEvent 'modal:error', @onError

	onError: (errors, scope) ->
		$("#modal-submit").spin false
		$("#modal-submit").text 'Login'

	modalRedirect: (path, scope) ->
		log "Modal called redirect to:",
			path: path
			scope: scope

		$('.modal-backdrop').remove() #Remove old backdrop
		$.proxy(@dispose, scope) #Dispose old modal

		@redirectTo path

	modalSubmit: ->
		$("#modal-submit").text ''
		$("#modal-submit").spin
			lines: 11
			length: 3
			width: 2
			radius: 5
			corners: 0
			rotate: 0
			color: '#000'
			speed: 1
			trail: 50
			shadow: false
			hwaccel: false
			className: 'spinner'
			zIndex: 100
			top: 'auto'
			left: 'auto'
