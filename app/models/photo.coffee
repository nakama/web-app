{api, log, mediator, Model} = require 'common'

module.exports = class Photo extends Model

	initialize: ->
		super
		log "Initializing the Photo Model"

	fetch: ->

		mediator.publish 'api', 'photos:fetch', mediator.user