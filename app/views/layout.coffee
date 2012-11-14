Chaplin    = require 'chaplin'
User       = require 'models/user'
HeaderView = require 'views/header'
UploadView = require 'views/upload'

module.exports = class Layout extends Chaplin.Layout

	events:
		'click a[href="#upload"]': 'showUpload'

	initialize: ->
		super

		console.log "Initializing the Layout"

		@header = new HeaderView
			#model: User

	showUpload: (e) ->
		e.preventDefault()

		console.log "Showing Upload"

		@upload = new UploadView
			#model: User