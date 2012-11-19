View = require 'views/base/view'

module.exports = class ModalView extends View
	#container: 'body'
	className: 'modal hide fade'
	attributes:
		role: 'dialog'
		'aria-hidden': true
		tabindex: '-1'
		
	initialize: (options) ->
		@options.size = options?.size || 'normal'

	afterRender: ->
		# Setup automatic disposal
		@$el.on 'hidden', $.proxy(@dispose, @)

		@$el.addClass 'size-' + @options.size

		# Show it
		@$el.modal 'show'
