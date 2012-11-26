{log, mediator, View} = require 'common'
template              = require 'views/templates/header'
UploadView            = require 'views/upload'

module.exports = class HeaderView extends View
	autoRender: true
	className: "navbar-inner"
	container: 'body'
	containerMethod: 'prepend'
	tagName: 'header'
	template: template

	events:
		'click a[href="#upload"]': 'upload'
		'click a[href="#settings"]': 'settings'
		'click a[href="#logout"]': 'onLogout'

	initialize: ->
		super
		log("Initializing the Header View")
		
		if @model or @collection
			rendered = no
			@modelBind 'change', =>
				log "Header View re-rendering",
					model: @model

				@render(yes)
				rendered = yes

	onLogout: (e) ->
		e.preventDefault()

		mediator.publish 'auth:logout'

	settings: (e) ->
		e.preventDefault()

	upload: (e) ->
		e.preventDefault()

		mediator.user.set('urlInstagramRedirect', 'http://localhost.naka.ma:3001/oauth')

		new UploadView
			model: mediator.user
