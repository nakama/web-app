{Controller, log, mediator} = require 'common'
ConnectView                 = require 'views/connect'
PhotoCollection             = require 'collections/photos'
PhotoCollectionView         = require 'views/photo_collection_view'

module.exports = class DashboardController extends Controller
	historyURL: 'dashboard'

	initialize: ->
		super

	index: ->
		@collection = new PhotoCollection
		@view = new PhotoCollectionView
		    collection: @collection
		#@view.collection.fetch()
		#mediator.publish 'api', 'photos:fetch', mediator.user.attributes
		mediator.publish 'api', 'photos:list', mediator.user.attributes
