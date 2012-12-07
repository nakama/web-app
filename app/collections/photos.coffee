{Collection, log, mediator} = require 'common'
Photo                       = require 'models/photo'

module.exports = class Photos extends Collection
	model: Photo
	#url: '/photos.json'
	#url: 'https://api.instagram.com/v1/users/self/feed?access_token=18632811.6692e4c.5c9a339173dc4fe9ae0faff04c363a56'
	
	initialize: ->
		super
		log "Initializing the Photo Collection"

		@subscribeEvent 'api:photos:fetched', @onFetched

	#sync: (method, model, options) ->
		###
		params = _.extend
			type: 'GET'
			dataType: 'jsonp'
			url: @url
			processData: false
		, options

		$.ajax(params)
		###

	#parse: (response) ->
		###
		log "Instragram response",
			response: response
		
		response.data
		###

	#fetch: ->
	#	mediator.publish 'api', 'photos:fetch', mediator.user.attributes

	
	onFetched: (photos) ->
		if photos instanceof Array

			log "Photos fetched",
				photos: photos

			#@add photos
			
			_.each photos, (photo, inc) =>
				#delete photo.attributes
				#delete photo.id
				#photo.id = inc
				photo = new Photo photo
				console.log photo
				@add photo

			mediator.publish 'isotope:reset'
