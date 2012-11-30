{api, log, Model} = require 'common'

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
		console.log @

	create: (data, callback) ->
		log 'Creating user...',
			data: data

		options = 
			data: data
			url: '/auth/user/add'

		api.call @, options, callback

	find: (options, callback) ->

		url = '/auth/user/get'

		if options

			# Get user by service and service identifier (id, token)
			if options.service? and options.identifier? and options.value?
				url += "/#{options.service}/#{options.identifier}/#{options.value}"

			# Get user by ID explicit
			else if options.id?
				url += "/#{options.id}"

			# Get uesr by ID
			else if typeof options is 'string'
				url += "/#{options}"

			# Don't have enough information to get user
			else
				console.warn "Please fix the options for user.get()"
				return

			options =
				type: 'GET'
				url: url

			log 'Getting user...',
				options: options

			api.call @, options, callback

	login: (data, callback) ->
		log 'Logging in user...',
			data: data

		options = 
			data: data
			url: '/auth/user/login'

		api.call @, options, callback

	loginInstagram: (data, callback) ->
		log 'Logging in Instagram user...',
			data: data

		options = 
			data: data
			url: '/auth/user/login/instagram'

		api.call @, options, callback

	update: (data, callback) ->
		log 'Updating user...',
			data: data

		options = 
			data: data
			url: '/auth/user/update'

		api.call @, options, callback
