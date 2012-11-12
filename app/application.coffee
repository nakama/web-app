Chaplin = require 'chaplin'
mediator = Chaplin.mediator
routes = require 'routes'
Layout = require 'views/layout'

# The application object
module.exports = class Application extends Chaplin.Application
  # Set your application name here so the document title is set to
  # “Controller title – Site title” (see Layout#adjustTitle)
  title: 'Nakama'

  initialize: ->
    super

    # Initialize core components
    @initDispatcher()
    @initMediator()
    @initTemplateHelpers()
    @initLayout()

    # Application-specific scaffold
    @initControllers()

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

  # Instantiate common controllers
  # ------------------------------
  initControllers: ->

  # Create additional mediator properties
  # -------------------------------------
  initMediator: ->
    # Create a user property
    mediator.user = null
    # Add additional application-specific properties and methods
    # Seal the mediator
    mediator.seal()
