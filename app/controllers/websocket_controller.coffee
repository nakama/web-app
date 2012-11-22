{Controller, log, mediator} = require 'common'

module.exports = class WebsocketController extends Controller

	initialize: ->
		super
		log 'Loading Websocket Controller'

		socket = io.connect window.location.origin

		socket.on 'msg', (data) ->
			log data
