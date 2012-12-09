Chaplin  = require 'chaplin'
logger   = require 'lib/logger'
log      = logger.log

module.exports = common =
	api: (options, callback) ->
		log 'API call initialized',
			options: options

		data = if options.data then JSON.stringify(options.data) else null
		set  = options.set or yes

		$.ajax
			type: options.type or 'POST'
			url: 'http://ec2-23-23-8-2.compute-1.amazonaws.com:8080' + options.url
			data: data

			success: (data, status, jqxhr) =>
				log 'API call successful',
					arguments: arguments

				if set
					@set options.data

				if typeof callback is 'function'
					callback(data, status, jqxhr)

			error: ->
				log 'API call failed',
					arguments: arguments

	mediator : Chaplin.mediator

	error    : logger.error
	log      : logger.log
	warn     : logger.warn

	Collection     : require 'models/base/collection'
	CollectionView : require 'views/base/collection_view'
	Controller     : require 'controllers/base/controller'
	ModalView      : require 'views/base/modal'
	Model          : require 'models/base/model'
	PageView       : require 'views/base/page_view'
	View           : require 'views/base/view'
	Application    : module.exports = class Application extends Chaplin.Application
		title: 'Nakama'

		initialize: ->
			#super

			# Initialize core components
			$.ajaxSetup
				cache: false
				dataType: 'json'
				contentType: 'application/json'
				headers:            
					'Accept' : 'application/json'

			#@initMediator()
			@initTemplateHelpers()
			@initDispatcher()
			@initLayout()

			# Application-specific scaffold
			WebsocketController = require 'controllers/websocket_controller'
			new WebsocketController

			AuthController = require 'controllers/auth_controller'
			new AuthController

			LayoutController = require 'controllers/layout_controller'
			new LayoutController

			ModalController = require 'controllers/modal_controller'
			new ModalController

			# Register all routes and start routing
			routes   = require 'routes'
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
			Layout   = require 'views/layout'
			@layout = new Layout {@title}

		# Instantiate template helpers
		# ------------------------------
		initTemplateHelpers: ->
			require 'views/templates/helpers/common'

		# Create additional mediator properties
		# -------------------------------------
		initMediator: ->
			# Create a user property
			mediator.user = null
			# Add additional application-specific properties and methods
			# Seal the mediator
			#mediator.seal()