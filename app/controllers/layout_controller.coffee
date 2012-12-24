Controller   = require 'controllers/base/controller'
{log}        = require 'lib/logger'
mediator     = require 'mediator'
ConnectView  = require 'views/connect'

module.exports = class LayoutController extends Controller

	initialize: ->
		super

		log 'Initializing the Layout Controller'
