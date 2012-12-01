{Controller, log, mediator} = require 'common'
PhotoCollection             = require 'collections/photos'
PhotoCollectionView         = require 'views/photo_collection_view'

module.exports = class DashboardController extends Controller
	historyURL: 'dashboard'

	index: ->
		log 'Loading Photo Collection'

		mediator.publish 'api', 'photos:fetch', mediator.user.attributes

		###
		@collection = new PhotoCollection
		@view = new PhotoCollectionView
		    collection: @collection
		@view.collection.fetch()
		###
