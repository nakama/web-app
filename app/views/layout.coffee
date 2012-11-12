Chaplin    = require 'chaplin'
User       = require 'models/user'
HeaderView = require 'views/header'
UploadView = require 'views/upload'

module.exports = class Layout extends Chaplin.Layout

	initialize: ->
    	super
    
    	console.log "Initializing the Layout"

    	@header = new HeaderView
    		#model: User

    	@upload = new UploadView
    		#model: User
