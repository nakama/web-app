Collection = require 'collections/base/collection'
{log}      = require 'lib/logger'
mediator   = require 'mediator'
Photo      = require 'models/photo'

module.exports = class Photos extends Collection
	model: Photo
	
	initialize: ->
		super
		log "Initializing the Photo Collection"

		@subscribeEvent 'api:photos:fetched', @onFetched
	
	onFetched: (photos) ->
		if photos instanceof Array

			log "Photos fetched",
				photos: photos

			#@add photos
			
			_.each photos, (photo, inc) =>
				photo = new Photo photo
				console.log photo
				@add photo

			mediator.publish 'isotope:reset'
