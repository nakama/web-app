Chaplin    = require 'chaplin'
User       = require 'models/user'
HeaderView = require 'views/header'
UploadView = require 'views/upload'

module.exports = class Layout extends Chaplin.Layout

	events:
		'click a[href="#upload"]' : 'showUpload'
		'click #modal-submit'     : 'modalSubmit'

	initialize: ->
		super

		console.log "Initializing the Layout"

		@header = new HeaderView
			#model: User

	modalSubmit: (e) ->
		e.preventDefault()

		$("#modal-submit").text ''
		$("#modal-submit").spin
			lines: 11
			length: 3
			width: 2
			radius: 5
			corners: 0
			rotate: 0
			color: '#000'
			speed: 1
			trail: 50
			shadow: false
			hwaccel: false
			className: 'spinner'
			zIndex: 100
			top: 'auto'
			left: 'auto'

	showUpload: (e) ->
		e.preventDefault()

		console.log "Showing Upload"

		@upload = new UploadView
			#model: User