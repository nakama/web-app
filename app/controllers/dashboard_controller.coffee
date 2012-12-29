Controller            = require 'controllers/base/controller'
{log}                 = require 'lib/logger'
mediator              = require 'mediator'
ConnectView           = require 'views/connect'
PhotoCollection       = require 'collections/photos'
PhotosCollections     = require 'collections/photos_collections'
PhotoCollectionView   = require 'views/photo_collection_view'
PhotosCollectionsView = require 'views/collections/photos_collections'

module.exports = class DashboardController extends Controller
	historyURL: 'dashboard'

	initialize: ->
		super

		@subscribeEvent 'api:collections:fetched', @onCollectionsFetched

	index: ->
		@collection = new PhotoCollection
		@view = new PhotoCollectionView
		    collection: @collection

		###
		data =
			skip: "0"
			limit: "100"
			user: mediator.user.toJSON()


		mediator.publish 'api', 'photos:collections', data
		###

	collections: ->
		@collection = new PhotosCollections
		@view = new PhotosCollectionsView
		    collection: @collection
		    template: require 'views/templates/collections/item'

		data =
			skip: "0"
			limit: "100"
			user: mediator.user.toJSON()

		mediator.publish 'api', 'collections:fetch', data	

	onCollectionsFetched: (res) ->

		if res
			###
			data =
				collections:
					id: res[0]._id
				skip: "0"
				limit: "10"
				user:
					id: mediator.user.get 'id'

			mediator.publish 'api', 'photos:list', data
			###

			###
			data =
				collection:
					_id: res[0]._id
				skip: "20"
				limit: "10"
				user:
					id: mediator.user.get 'id'

			mediator.publish 'api', 'photos:list', data
			###
