{Controller, log, mediator} = require 'common'
User                   = require 'models/user'
JoinView               = require 'views/join'
LoginView              = require 'views/login'

module.exports = class ModalController extends Controller
	
	initialize: ->
		super

		@subscribeEvent 'modal:redirect', @modalRedirect

	modalRedirect: (path) ->
		log "Modal called redirect to:", path

		@redirectTo path
