Model = require 'models/base/model'

module.exports = class User extends Model

	initialize: ->
		super

	create: (options, callback) ->
		console.log "Creating user...", options

		$.ajax
			type: "POST"
			url: "http://50.19.65.14:8080/auth/user/add"
			data: options
			success: (data, status, jqxhr) ->
				console.log "User creation successful", arguments
				if typeof callback is "function"
					callback(data, status, jqxhr)

			error: ->
				console.log "User creation failed", arguments

	login: (options) ->
		console.log "Logging in user..."

		$.ajax
			type: "POST"
			url: "http://50.19.65.14:8080/auth/user/login"
			data: options
			success: ->
				console.log "User login successful", arguments
			error: ->
				console.log "User login failed", arguments