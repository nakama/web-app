{log, mediator} = require 'common'
Instagram       = require 'models/instagram'
ModalView       = require 'views/base/modal'
template        = require 'views/templates/connect'

module.exports = class ConnectView extends ModalView
  template: template
  container: 'body'
  autoRender: true
  id: "view-connect"

  events:
    #'click #modal-submit'              : 'onSubmit'
    'click a[href="#create-account"]'   : 'showCreateAccountView'
    #'click a[href="#connectfacebook"]'  : 'connectFacebook'
    'click a[href="#connectinstagram"]' : 'connectInstagram'

  initialize: (data) ->
    super
    log "Initializing the Connect View",
      model: @model

  afterRender: ->
    super

    #if location.pathname is '/dashboard'
      #console.log "hit"
      #$('#login-services-custom').hide()
    
  #### Connect Instagram
  # Attempt to connect a user to Nakama using Instagram
  #
  # `e` should be an `Object`

  connectInstagram: (e) ->
    e.preventDefault()

    user = @model
    view = @

    instagram = new Instagram

    instagram.login (res, err) ->

      # There was an error connecting to Instagram
      if err
        console.warn "There was a problem connecting to Instagram."
        return
      
      options = 
        service: 'instagram'
        identifier: 'id'
        value: res.session.id

      # See if user exists in Nakama with Instagram ID
      user.find options, (data) ->

        # User exists
        if data.message is 'success' and data.object?

          # Log in existing user

          log "Instagram user exists",
            data: data.object

          user.loginInstagram data.object, (res) ->
            log "Login Instagram data response", res

            mediator.publish 'auth:success', res.object, view

        # Assume new user
        else

          # Populate Instagram data for new account

          log "Instagram user does not exists"

          $name     = $('#create-account-name')
          $email    = $('#create-account-email')
          $username = $('#create-account-username')
          $avatar   = $('#create-account-avatar')

          $name.val(res.session.full_name)
          $avatar.val(res.session.profile_picture)

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
                  avatar: res.session.profile_picture
                  id: res.session.id
                  auth_token: res.session.access_token
                  username: res.session.username

            # Create a new user in Nakama
            user.create data, (data) ->
              console.log "Join data response", data

              mediator.publish 'auth:success', data.object, view

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
