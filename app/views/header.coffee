{log, mediator, View} = require 'common'
template              = require 'views/templates/header'

module.exports = class HeaderView extends View
	autoRender: true
	className: "navbar-inner"
	container: 'body'
	containerMethod: 'prepend'
	tagName: 'header'
	template: template

	events:
		#'click a[href="#settings"]' : 'settings'
		'click a[href="#logout"]'   : 'onLogout'
		'click #grid-layouts a'     : 'toggleGrid'

	initialize: ->
		super
		log 'Initializing the Header View'

		@modelBind 'change', @render

	afterRender: ->
		super

		$('#grid-slider').change (e) ->
			val = $(this).val()

			mediator.publish 'grid:toggle', val

		$("#global-search").textext(
			plugins: 'autocomplete filter tags'
			autocomplete:
				dropdownMaxHeight: "200px"

				render: (suggestion) ->
					"<div style=\"background-image:url("+suggestion.path+")\">" + suggestion.author + "<p>Lorem ipsum dolor sit amet, consectetur adipisicing " + "elit...</p></div>"

		).bind "getSuggestions", (e, data) ->
			$.ajax
				dataType : 'json'
				url: '/photos.json'
				success: (res) =>

					textext = $(e.target).textext()[0]
					query = ((if data then data.query else "")) or ""

					result = _.filter res, (item) ->
						textext.itemManager().filter(item.author, query)
					
					$(this).trigger "setSuggestions",
						result: result

	onLogout: (e) ->
		e.preventDefault()

		mediator.publish 'auth:logout'

	toggleGrid: (e) ->
		e.preventDefault()

		mediator.publish 'grid:toggle', e

	###
	settings: (e) ->
		e.preventDefault()
	###
