Chaplin  = require 'chaplin'
logger   = require 'lib/logger'
log      = logger.log

module.exports = common =
	api: (options, callback) ->
		log 'API call initialized',
			options: options

		set = options.set or yes

		$.ajax
			type: options.type or 'POST'
			url: 'http://50.19.65.14:8080' + options.url
			data: JSON.stringify(options.data)

			success: (data, status, jqxhr) =>
				log 'API call successful',
					arguments: arguments

				if set
					log 'Model set'
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
	Model          : require 'models/base/model'
	PageView       : require 'views/base/page_view'
	View           : require 'views/base/view'
	Application    : Chaplin.Application.extend
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
			@initControllers()

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

		# Instantiate common controllers
		# ------------------------------
		initControllers: ->
			AuthController = require 'controllers/auth_controller'
			@auth = new AuthController

			ModalController = require 'controllers/modal_controller'
			@modal = new ModalController

		# Create additional mediator properties
		# -------------------------------------
		initMediator: ->
			# Create a user property
			mediator.user = null
			# Add additional application-specific properties and methods
			# Seal the mediator
			#mediator.seal()