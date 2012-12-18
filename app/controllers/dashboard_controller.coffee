{Controller, log, mediator} = require 'common'
ConnectView                 = require 'views/connect'
PhotoCollection             = require 'collections/photos'
PhotoCollectionView         = require 'views/photo_collection_view'

module.exports = class DashboardController extends Controller
	historyURL: 'dashboard'

	initialize: ->
		super

		@subscribeEvent 'api:photos:collections:fetched', @onCollectionsFetched

	index: ->
		@collection = new PhotoCollection
		@view = new PhotoCollectionView
		    collection: @collection
		#@view.collection.fetch()
		data =
			user: mediator.user.toJSON()

		mediator.publish 'api', 'photos:collections', data
		
		

	onCollectionsFetched: (res) ->
		console.log "res", res

		if res
			data =
				collection:
					_id: res[0]._id
				user: mediator.user.toJSON()

			mediator.publish 'api', 'photos:list', data
