Controller       = require 'controllers/base/controller'
{log}            = require 'lib/logger'
mediator         = require 'mediator'
User             = require 'models/user'

module.exports = class ModalController extends Controller
	
	initialize: ->
		super

		@subscribeEvent 'modal:clear', @onClear
		@subscribeEvent 'modal:error', @onError
		@subscribeEvent 'modal:redirect', @onRedirect
		@subscribeEvent 'modal:submit', @onSubmit

	onClear: ->
		$('.modal-backdrop').remove()

	onError: (errors, scope) ->
		$("#modal-submit").spin false
		$("#modal-submit").text 'Login'

	onRedirect: (path, scope) ->
		log "Modal called redirect to:",
			path: path
			scope: scope

		$('.modal-backdrop').remove() #Remove old backdrop
		$.proxy(@dispose, scope) #Dispose old modal

		@redirectTo path

	onSubmit: ->
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
