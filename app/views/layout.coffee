Chaplin    = require 'chaplin'
User       = require 'models/user'
HeaderView = require 'views/header'
#UploadView = require 'views/upload'

module.exports = class Layout extends Chaplin.Layout

	events:
        'click a[href="#upload"]': 'upload'

	initialize: ->
    	super
    
    	console.log "Initializing the Layout"

    	@header = new HeaderView
    		modal: User

    upload: ->
		#e.preventDefault()

		console.log "hittttt"