Controller = require 'controllers/base/controller'
PhotoCollection     = require 'collections/photos'
PhotoView  = require 'views/photo_view'
PhotoCollectionView  = require 'views/photo_collection_view'

logger = require 'lib/logger'
log    = logger.log

module.exports = class DashboardController extends Controller
  historyURL: 'dashboard'

  index: ->
    log 'Loading Photo Collection'

    #new PhotoController
    @view = new PhotoCollectionView
        collection: new PhotoCollection()
    PhotoCollection.fetch()

    #@render = ->
    #	new PhotoCollectionView({collection: @collection})
    #    #@collection.each (photo) ->
    #		#new PhotoView(photo)
    #
    #@collection = new Photos()
    #@collection.fetch()
    #@collection.on("reset",@render,this)
    
    #@collection.each (photo) ->
    #	console.log photo
    #_.each @collection.models, (photo, key) ->
    #	console.log photo
    	#new PhotoView({photo})
    #for photo in @collection.models
    #	do (photo) ->
    #		new PhotoView({photo})

    # @view = new PhotoView({@collection})
