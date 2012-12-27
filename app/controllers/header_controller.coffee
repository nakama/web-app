Controller  = require 'controllers/base/controller'
{log}       = require 'lib/logger'
mediator    = require 'mediator'
HeaderView  = require 'views/header'
SearchView            = require 'views/search'
SecondaryView         = require 'views/header/secondary'

module.exports = class HeaderController extends Controller

	initialize: ->
		super
		log 'Initializing the Header Controller'

		@view = new HeaderView
			model: mediator.user

		@view.subview 'searchView', new SearchView
			model: @view.model

		@view.subview 'secondaryView', new SecondaryView
			model: @view.model
