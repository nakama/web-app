{Controller, mediator} = require 'common'
User = require 'models/user'
JoinView = require 'views/join'

module.exports = class AuthController extends Controller
	
	initialize: ->
		super
		@user = mediator.user = new User

	join: ->
		new JoinView
			model: new User