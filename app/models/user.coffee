{api, log, mediator, Model} = require 'common'

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

	checkAuth: ->
		window.fbAsyncInit = =>
			FB.init
				appId      : '229944863802496'
				channelUrl : '//localhost.naka.ma/channel.html'
				status     : true
				cookie     : true
				xfbml      : true

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


	connectFacebook: (e, model) ->
	    e?.preventDefault()

	    user = if model then model else mediator.user

	    FB.login (response) ->
	      
	      # Connected
	      if response.authResponse
	        
	        log "Connected to Facebook",
	          response: response

	        # See if user exists with Facebook ID
	        options = 
	          service: 'facebook'
	          identifier: 'id'
	          value: response.authResponse.userID

	        user.find options, (data) ->
	          console.log arguments

	          # Found existing user
	          if data.message is 'success' and data.object?

	            # Log in existing user

	          # Assume new user
	          else

	            # Populate Facebook data for new account

	            # Create new user account
	            # user.create 
	      
	      # Cancelled
	      else
	        #window.location.href = '/'
	    , {scope:'user_photos'}

	connectInstagram: ->
		# do nothing

	create: (data, callback) ->

		options = 
			data: data
			url: '/auth/user/add'

		api.call @, options, callback

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
		# do nothing

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
