Collection      = require 'collections/base/collection'
{log}           = require 'lib/logger'
mediator        = require 'mediator'
PhotoCollection = require 'models/photo_collection'

module.exports = class PhotosCollections extends Collection
	model: PhotoCollection
	
	initialize: ->
		super
		log "Initializing the Photos Collections Collection"

		@subscribeEvent 'api:photos:collections:fetched', @onFetched
	
	onFetched: (photosCollections) ->

		if photosCollections instanceof Array

			log "Photos Collections fetched",
				photosCollections: photosCollections

			_.each photosCollections, (photoCollection) =>
				photoCollection = new PhotoCollection photoCollection
				console.log photoCollection
				@add photoCollection

			mediator.publish 'isotope:reset'
