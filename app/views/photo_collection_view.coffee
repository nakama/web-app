CollectionView = require 'views/base/collection_view'
itemView       = require 'views/photo_collection_item_view'
template       = require 'views/templates/photo_collection'

module.exports = class PhotoCollectionView extends CollectionView
  template: template
  container: '#page-container'
  autoRender: true
  itemView: itemView
  # listSelector: '#photos-list'

  initialize: (data) ->
  	super
  	# console.log "Collection data"
  	# console.log data

  afterRender: ->
  	console.log 'rendering collection'
