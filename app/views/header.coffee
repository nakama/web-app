{log, mediator, View}   = require 'common'
template = require 'views/templates/header'

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
		console.log("Initializing the Header View");

	settings: (e) ->
		e.preventDefault()

