Chaplin    = require 'chaplin'
User       = require 'models/user'
HeaderView = require 'views/header'

module.exports = class Layout extends Chaplin.Layout

	initialize: ->
    	super
    
    	@header = new HeaderView
    		modal: User
