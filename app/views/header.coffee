{log}            = require 'lib/logger'
mediator              = require 'mediator'
SearchView            = require 'views/search'
SecondaryView         = require 'views/header/secondary'
template              = require 'views/templates/header'
View                  = require 'views/base/view'

module.exports = class HeaderView extends View
	autoRender: true
	#className: "navbar-inner"
	container: 'body'
	containerMethod: 'prepend'
	tagName: 'header'
	template: template

	events:
		#'click a[href="#settings"]' : 'settings'
		'click a[href="#logout"]'         : 'onLogout'
		'click #grid-layouts a'           : 'toggleGrid'
		'click a[href="#settings"] i'       : 'onSettings'

	initialize: ->
		super
		log 'Initializing the Header View'

		@modelBind 'change', @render

	afterRender: ->
		super

		new SearchView
			model: @model

		###
		new SecondaryView
			model: @model
		###

		$('#grid-slider').change (e) ->
			val = $(this).val()

			mediator.publish 'grid:toggle', val

		content = [
			'<menu>',
			'<li><a href="#logout">Logout</a></li>',
			'</menu>'
		].join '\n'

		@$settings = $('a[href="#settings"]').popover
			html: 'true'
			placement: 'bottom'
			title: 'Settings'
			#trigger: 'hover'
			content: content

		@$settingsVisible = false

	onLogout: (e) ->
		e.preventDefault()

		mediator.publish 'auth:logout'

	onSettings: (e) ->
		e.preventDefault()
		e.stopPropagation()

		if @$settingsVisible
			@$settings.popover 'hide'
			@$settingsVisible = true
		else
			@$settings.popover 'show'
			@$settingsVisible = false

	toggleGrid: (e) ->
		e.preventDefault()

		mediator.publish 'grid:toggle', e

	###
	settings: (e) ->
		e.preventDefault()
	###
