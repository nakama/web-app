api         = require 'lib/api'
{log}            = require 'lib/logger'
mediator    = require 'mediator'
Model       = require 'models/base/model'
Facebook    = require 'models/facebook'
Instagram   = require 'models/instagram'

module.exports = class User extends Model

	validation:
		username:
			required: true

	initialize: ->
		super

	checkAuth: ->
		# do nothing atm

	connectFacebook: (callback) ->
		e?.preventDefault()
			
		###
		FB.getLoginStatus (response) =>
			log 'Facebook Status',
				response: response

			# User has connected their facebook account
			if response.status is 'connected'
				log 'Facebook account is connected'

			# User has not connected their facebook account
			else if response.status is 'not_authorized'
				log 'Facebook account is not authorized'

			# User is not logged in
			else
				log 'Facebook account is not logged in'

				@connectFacebook()
		###

		FB.login (response) =>

			# Connected
			if response.authResponse

				log "Connected to Facebook",
					response: response

				# See if user exists with Facebook ID
				options = 
					service: 'facebook'
					identifier: 'id'
					value: response.authResponse.userID

				@find options, (data) =>
					console.log arguments

					# Found existing user
					if data.message is 'success' and data.object?

						# Log in existing user

						log "Facebook user exists",
							data: data.object

						@loginFacebook data.object, (res) ->
							log "Login Facebook data response", res
							auth_token = response.authResponse.accessToken
							callback(true, res, auth_token)

					# Assume new user
					else
						console.log "2"
						callback(false, response)

			# Cancelled
			else
				#window.location.href = '/'
		, {scope:'user_photos'}

	connectInstagram: (callback) ->

		instagram = new Instagram
		user      = @

		instagram.login (res, err) =>

			# There was an error connecting to Instagram
			if err
				console.warn "There was a problem connecting to Instagram."
				return

			options = 
				service: 'instagram'
				identifier: 'id'
				value: res.session.id

			# See if user exists in Nakama with Instagram ID
			@find options, (data) =>

				# User exists
				if data.message is 'success' and data.object?
					console.log "1"
					# Log in existing user

					log "Instagram user exists",
						data: data.object

					@loginInstagram data.object, (res) ->
						log "Login Instagram data response", res
						callback(true, res)

				else
					console.log "2"
					callback(false, res)

	create: (data, callback) ->

		options = 
			data: data
			url: '/auth/user/add'

		api.call @, options, callback

	# Create new user from oAuth service
	createByService: (service, data, callback) ->

		log "User does not exist for service: #{service} - creating new user",
			data: data

		user = 
			username: data.username
			password: 'oauth-xxx'
			profile:
				name: data.name
				email: data.email
			services: {}

		user.services[service] =
			avatar: data.session.profile_picture
			id: data.session.id
			auth_token: data.session.auth_token
			username: (data.session.username or "")

		# Create a new user in Nakama
		@create user, (res) ->
			console.log "Join data response", res

			mediator.user.set user
			store.set 'nakama-user', user
			callback(res)

	delete: ->
		# do nothing

	find: (options, callback) ->

		url = '/auth/user/get'

		if options

			# Get user by service and service identifier (id, token)
			if options.service? and options.identifier? and options.value?
				url += "/#{options.service}/#{options.identifier}/#{options.value}"

			# Get user by ID explicit
			else if options.id?
				url += "/id/#{options.id}"

			# Get uesr by ID
			else if typeof options is 'string'
				url += "/id/#{options}"

			# Don't have enough information to get user
			else
				console.warn "Please fix the options for user.get()", options

			options =
				type: 'GET'
				url: url

			api.call @, options, callback

	findByFacebookID: (id) ->
		# need to implement

	findByInstagramID: (id) ->
		# need to implement

	login: (data, callback) ->

		options = 
			data: data
			type: 'POST'
			url: '/auth/user/login'

		api.call @, options, callback

	loginFacebook: (data, callback) ->
		options = 
			data: data
			url: '/auth/user/login/facebook'

		api.call @, options, callback

	loginInstagram: (data, callback) ->

		options = 
			data: data
			url: '/auth/user/login/instagram'

		api.call @, options, callback

	update: (data, callback) ->

		options = 
			data: data
			url: '/auth/user/update'

		api.call @, options, callback
