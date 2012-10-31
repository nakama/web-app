Controller           = require 'controllers/base/controller'
PhotoCollection      = require 'collections/photos'
PhotoView            = require 'views/photo_view'
PhotoCollectionView  = require 'views/photo_collection_view'

module.exports = class PhotoController extends Controller
  initialize: (data) ->
    super
    @collection = new PhotoCollection()
    @collection.fetch()
    @collection.on("reset", @render, @)
    #@view = new PhotoView({@collection})

  render: ->
  	@view = new PhotoCollectionView collection: @collection