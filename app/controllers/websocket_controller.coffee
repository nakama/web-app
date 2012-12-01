{Controller, log, mediator} = require 'common'

module.exports = class WebsocketController extends Controller

	initialize: ->
		super
		log 'Initializing the Websocket Controller'

		@subscribeEvent 'socket:msg', @msg
		@subscribeEvent 'api', @api

		@socket = io.connect window.location.origin

		@socket.on 'msg', (data) ->
			log "Received message from server",
				data: data

	api: (call, data) ->
		log "Making API call: #{call}",
			data: data

		@socket.emit "api:#{call}", data

	msg: (data) ->
		log 'Sending message to server',
			data: data

		@socket.emit 'server:msg', data
