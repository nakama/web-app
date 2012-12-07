{log, mediator} = require 'common'
ModalView       = require 'views/base/modal'
template        = require 'views/templates/connect'

module.exports = class ConnectView extends ModalView
  template: template
  container: 'body'
  autoRender: true
  id: "view-connect"

  events:
    #'click #modal-submit'              : 'onSubmit'
    'click a[href="#create-account"]'  : 'showCreateAccountView'
    'click a[href="#connectfacebook"]' : 'connectFacebook'
    'click a[href="#connectinstagram"]' : 'connectInstagram'

  initialize: (data) ->
    super
    log "Initializing the Connect View",
      model: @model

  connectFacebook: (e) ->
    e.preventDefault()

    user = @model

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
    , {scope:'user_photos,offline_access'}
    
  connectInstagram: (e) ->
    e.preventDefault()

    user = @model
    view = @

    IG.login (response) ->
      if response.session
        
        # See if user exists with Instagram ID
        options = 
          service: 'instagram'
          identifier: 'id'
          value: response.session.id

        user.find options, (data) ->

          # Found existing user
          if data.message is 'success' and data.object?

            # Log in existing user

            log "Instagram user exists",
              data: data.object

            user.loginInstagram data.object, (data) ->
              log "Login Instagram data response", data

              mediator.publish 'auth:success', data.object, view

          # Assume new user
          else

            # Populate Instagram data for new account

            log "Instagram user does not exists"

            $name     = $('#create-account-name')
            $email    = $('#create-account-email')
            $username = $('#create-account-username')
            $avatar   = $('#create-account-avatar')
            $id       = $('#create-account-id')
            $token    = $('#create-account-token')
            $susername = $('#create-account-service-username')

            $name.val(response.session.full_name)
            $avatar.val(response.session.profile_picture)
            $token.val(response.session.access_token)
            $id.val(response.session.id)
            $susername.val(response.session.username)

            $('#login-services-wrapper').hide()
            $('#login-services-extra').show()
            $('#modal-submit').text('Submit')

            $('#modal-submit').on 'click', (e) ->
              e.preventDefault()

              data = 
                username: $username.val()
                password: 'oauth-xxx'
                profile:
                  name: $name.val()
                  email: $email.val()
                services:
                  instagram:
                    avatar: $avatar.val()
                    id: $id.val()
                    auth_token: $token.val()
                    username: $susername.val()

              user.create data, (data) ->
                console.log "Join data response", data

                mediator.publish 'auth:success', data.object, view


    , {scope: ['comments', 'likes']}

  onSubmit: (e) =>
    e.preventDefault()
    
    data = 
      username: $('#create-account-username').val()
      password: null
      profile:
        name: $('#create-account-name').val()
        email: $('#create-account-email').val()
      services:
        instagram:
          avatar: $('#create-account-avatar').val()
          id: $('#create-account-id').val()
          token: $('#create-account-token').val()
          username: $('#create-account-service-username').val()

    log "Submitting Login with the data:",
      data: data

    mediator.publish 'socket:msg', data

    @model.login data, ->

      mediator.publish 'auth:success', data

  showCreateAccountView: (e) ->
    e.preventDefault();
    mediator.publish 'modal:redirect', 'join', @
