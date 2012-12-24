api       = require 'lib/api'
{log}            = require 'lib/logger'
mediator  = require 'mediator'
Model     = require 'models/base/model'

module.exports = class Photo extends Model

	initialize: ->
		super
		###
		log "Initializing the Photo Model",
			scope: @
		###
