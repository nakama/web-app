{Controller, log} = require 'common'
HeaderView        = require 'views/header'
User              = require 'models/user'

module.exports = class HeaderController extends Controller
	historyURL: ''

	initialize: ->
		super
		log 'Loading Header View'

		@user = new User
		@view = new HeaderView
			model: @user
