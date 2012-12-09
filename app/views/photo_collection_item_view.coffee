View     = require 'views/base/view'
template = require 'views/templates/photo_collection_item'

module.exports = class PhotoCollectionItemView extends View
	template: template
	autoRender: false
	tagName: 'li'
	className: 'photo-wrapper'

	initialize: ->
		super

		@subscribeEvent 'grid:toggle', @togglePhotoSize

	render: ->
		super
		@togglePhotoSize()

	togglePhotoSize: (e) ->
		if e?.target
			size = $(e.target).attr('href').split('#')[1]
		else
			size = 'small'

		@$el.removeClass 'small'
		@$el.removeClass 'medium'
		@$el.removeClass 'row-long'
		@$el.addClass size
