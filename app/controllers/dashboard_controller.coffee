Controller = require 'controllers/base/controller'
PhotoCollection     = require 'collections/photos'
PhotoCollectionView  = require 'views/photo_collection_view'

logger = require 'lib/logger'
log    = logger.log

module.exports = class DashboardController extends Controller
  historyURL: 'dashboard'

  index: ->
    log 'Loading Photo Collection'

    @collection = new PhotoCollection
    @view = new PhotoCollectionView
        collection: @collection
    @view.collection.fetch()
