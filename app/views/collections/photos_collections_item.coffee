CollectionView = require 'views/base/collection_view'
{log}          = require 'lib/logger'
mediator       = require 'mediator'
template       = require 'views/templates/collections/item'
View           = require 'views/base/view'

module.exports = class PhotosCollectionsItemView extends View
	template: template
	autoRender: false
	tagName: 'li'
	className: 'photo-wrapper '

	initialize: (options) ->
		super

		console.log "hit"

		if options.templates
			@template = options.template

		log "model",
			model: @model

		@subscribeEvent 'grid:toggle', @togglePhotoSize

	render: ->
		super
		#@togglePhotoSize()

	afterRender: ->
		super
		@$el.addClass 'small'

	togglePhotoSize: (e) ->

		if typeof e is "string"
			size = e

		else if e?.target
			size = $(e.target).attr('href').split('#')[1]
		
		else
			size = '100'

		size = 'size-' + size

		@$el.removeClass 'size-100'
		@$el.removeClass 'size-150'
		@$el.removeClass 'size-200'
		@$el.removeClass 'size-250'
		@$el.removeClass 'size-300'
		@$el.removeClass 'size-350'
		@$el.removeClass 'size-400'
		@$el.removeClass 'size-450'
		@$el.removeClass 'size-500'
		@$el.removeClass 'size-550'
		@$el.removeClass 'size-600'
		@$el.removeClass 'size-650'
		@$el.removeClass 'size-700'
		@$el.removeClass 'size-750'
		@$el.removeClass 'size-800'
		@$el.removeClass 'size-850'
		@$el.removeClass 'size-900'
		@$el.removeClass 'size-950'
		@$el.removeClass 'size-1000'

		@$el.addClass size
