{Controller, log, mediator} = require 'common'
PhotoCollection             = require 'collections/photos'
PhotoCollectionView         = require 'views/photo_collection_view'

module.exports = class DashboardController extends Controller
	historyURL: 'dashboard'

	initialize: ->
		

	index: ->
		@collection = new PhotoCollection
		@view = new PhotoCollectionView
		    collection: @collection
		@view.collection.fetch()
