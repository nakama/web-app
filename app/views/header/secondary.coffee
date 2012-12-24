{log}            = require 'lib/logger'
mediator       = require 'mediator'
template       = require 'views/templates/header/secondary'
View           = require 'views/base/view'

module.exports = class SecondaryView extends View
	autoRender: true
	className: 'secondary navbar-inner'
	container: 'nav.navigation'
	tagName: 'div'
	template: template

	initialize: ->
		super
		log 'Initializing the Secondary View'

		@modelBind 'change', @render
