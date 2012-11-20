{log, Model} = require 'common'

module.exports = class User extends Model

	###
	defaults:
		username: null
	###

	validation:
		username:
			required: true

	initialize: ->
		super

	create: (options, callback) ->
		log "Creating user...",
			options: options

		$.ajax
			type: "POST"
			url: "http://50.19.65.14:8080/auth/user/add"
			data: options
			
			success: (data, status, jqxhr) ->
				log "User creation successful",
					arguments: arguments

				if typeof callback is "function"
					log "User model set with:",
						data: options

					@set options

					callback(data, status, jqxhr)

			error: ->
				log "User creation failed",
					arguments: arguments

	login: (options, callback) ->
		log "Logging in user...",
			options: options

		$.ajax
			type: "POST"
			url: "http://50.19.65.14:8080/auth/user/login"
			data: options

			success: (data, status, jqxhr) =>
				log "User login successful",
					arguments: arguments

				if typeof callback is "function"
					log "User model set with:",
						data: options

					@set options
					callback(data, status, jqxhr)

			error: ->
				log "User login failed",
					arguments: arguments
