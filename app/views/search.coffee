{log}            = require 'lib/logger'
mediator         = require 'mediator'
template         = require 'views/templates/search'
View             = require 'views/base/view'

module.exports = class SearchView extends View
	autoRender: true
	container: 'header .search-container'
	template: template

	initialize: ->
		super
		log 'Initializing the Search View'

		@modelBind 'change', @render

	afterRender: ->
		super

		$("#global-search").textext(
			plugins: 'autocomplete filter tags'
			autocomplete:
				dropdownMaxHeight: "200px"

				render: (suggestion) ->
					"<div style=\"background-image:url(" + suggestion.path + ")\">" + suggestion.author + "<p>Lorem ipsum dolor sit amet, consectetur adipisicing " + "elit...</p></div>"

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
