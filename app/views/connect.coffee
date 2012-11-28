{log, mediator} = require 'common'
ModalView       = require 'views/base/modal'
template        = require 'views/templates/connect'

module.exports = class ConnectView extends ModalView
  template: template
  container: 'body'
  autoRender: true
  id: "view-connect"

  events:
    'click #modal-submit'              : 'onSubmit'
    'click a[href="#create-account"]'  : 'showCreateAccountView'
    'click a[href="#connectfacebook"]' : 'connectFacebook'

  initialize: (data) ->
    super
    log "Initializing the Connect View",
      model: @model

  connectFacebook: (e) ->
    e.preventDefault()

    FB.login (response) =>
      # Connected
      if response.authResponse
        
        log "Connected to Facebook",
          response: response

        # User exists with Facebook ID
        options = 
          service: 'facebook'
          identifier: 'id'
          value: response.authResponse.userID

        @model.find options, (data) ->
          console.log arguments

          # Found existing user
          if data.message is 'success' and data.object?

            # Log in existing user

          # Assume new user
          else

            # Create new user account
      
      # Cancelled
      else
        window.location.href = '/'
    , {scope:'user_photos,offline_access'}
    
  onSubmit: (e) =>
    e.preventDefault();
    
    data = 
      username: $('#auth-username').val()
      password: $('#auth-password').val()

    log "Submitting Login with the data:",
      data: data

    mediator.publish 'socket:msg', data

    @model.login data, ->

      mediator.publish 'auth:success', data

  showCreateAccountView: (e) ->
    e.preventDefault();
    mediator.publish 'modal:redirect', 'join', @
