{log, mediator, View} = require 'common'
template              = require 'views/templates/header'

module.exports = class HeaderView extends View
	autoRender: true
	className: "navbar-inner"
	container: 'body'
	containerMethod: 'prepend'
	tagName: 'header'
	template: template

	events:
		'click a[href="#settings"]': 'settings'

	initialize: ->
		super
		log("Initializing the Header View");
		@model?.on 'change', @render, @

	settings: (e) ->
		e.preventDefault()
