Controller       = require 'controllers/base/controller'
{log}            = require 'lib/logger'
mediator         = require 'mediator'

module.exports = class WebsocketController extends Controller

	initialize: ->
		super
		log 'Initializing the Websocket Controller'

		@subscribeEvent 'api', @api

		@socket = io.connect window.location.origin

		@socket.on 'msg', (data) ->
			#log "Received message from server",
			#	data: data

			if data.api
				log "Received Web Socket Message: #{data.api}",
					data: data.object

				mediator.publish data.api, data.object

	api: (call, data) ->
		log "Making API call: #{call}",
			data: data

		@socket.emit "api:#{call}", data
