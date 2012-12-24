AuthController      = require 'controllers/auth_controller'
Chaplin             = require 'chaplin'
Layout              = require 'views/layout'
LayoutController    = require 'controllers/layout_controller'
logger              = require 'lib/logger'
log                 = logger.log
routes              = require 'routes'
ModalController     = require 'controllers/modal_controller'
WebsocketController = require 'controllers/websocket_controller'

module.exports = class Application extends Chaplin.Application
	title: 'Nakama'

	initialize: ->
		super

		# Initialize core components
		$.ajaxSetup
			cache        : false
			dataType     : 'json'
			contentType  : 'application/json'
			headers:            
				'Accept' : 'application/json'
			timeout      : 2500

		#@initMediator()
		@initTemplateHelpers()
		@initDispatcher()

		new LayoutController
		@initLayout()

		# Application-specific scaffold
		new WebsocketController
		new AuthController
		new ModalController

		# Register all routes and start routing
		@initRouter routes
		# You might pass Router/History options as the second parameter.
		# Chaplin enables pushState per default and Backbone uses / as
		# the root per default. You might change that in the options
		# if necessary:
		# @initRouter routes, pushState: false, root: '/subdir/'

		# Freeze the application instance to prevent further changes
		Object.freeze? this

	# Override standard layout initializer
	# ------------------------------------
	initLayout: ->
		# Use an application-specific Layout class. Currently this adds
		# no features to the standard Chaplin Layout, it’s an empty placeholder.
		
		@layout = new Layout {@title}

	# Instantiate template helpers
	# ------------------------------
	initTemplateHelpers: ->
		require 'views/templates/helpers/common'
		require 'views/templates/helpers/collections'

	# Create additional mediator properties
	# -------------------------------------
	initMediator: ->
		# Create a user property
		mediator.user = null
		# Add additional application-specific properties and methods
		# Seal the mediator
		#mediator.seal()