Controller        = require 'controllers/base/controller'
HeaderView        = require 'views/header'
User              = require 'models/user'

module.exports = class HeaderController extends Controller

	initialize: ->
		super
		console.log 'Loading Header View'

		@user = new User
		@view = new HeaderView
			model: @user
