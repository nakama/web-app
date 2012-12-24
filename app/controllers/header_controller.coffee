Controller  = require 'controllers/base/controller'
{log}       = require 'lib/logger'
mediator    = require 'mediator'
HeaderView  = require 'views/header'

module.exports = class HeaderController extends Controller

	initialize: ->
		super
		log 'Initializing the Header Controller'

		@view = new HeaderView
			model: mediator.user
