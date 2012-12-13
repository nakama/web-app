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
    'click a[href="#create-account"]'   : 'showCreateAccountView'
    'click a[href="#connectfacebook"]'  : 'connectFacebook'
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
    
  #### Connect Facebok
  # Attempt to connect a user to Nakama using Facebook
  #
  # `e` should be an `Object`

  connectFacebook: (e) ->
    e?.preventDefault()

    user = @model
    view = @

  #### Connect Instagram
  # Attempt to connect a user to Nakama using Instagram
  #
  # `e` should be an `Object`
  #

  connectInstagram: (e) ->
    e?.preventDefault()

    user = @model
    view = @

    user.connectInstagram (exists, res) =>
      log "Connecting to Instagram..."
        res: res

      # User exists
      if exists
        mediator.publish 'auth:success', res.object, view

      # Assume new user
      else
        @createNewUser res, (result) ->
          mediator.publish 'auth:success', result.object, view

  #### Create a new user
  #
  
  createNewUser: (res, callback) ->
    $name     = $('#create-account-name')
    $email    = $('#create-account-email')
    $username = $('#create-account-username')
    $avatar   = $('#create-account-avatar')

    $('#login-services-wrapper').hide()
    $('#login-services-extra').show()
    $('#modal-submit').text('Submit')

    $name.val(res.session.full_name)
    $avatar.val(res.session.profile_picture)

    $('#modal-submit').on 'click', (e) ->
      e.preventDefault()

      res.username = $username.val()
      res.name     = $name.val()
      res.email    = $email.val()

      user.createByService 'instagram', res, (result) ->
        callback(result)

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
          auth_token: $('#create-account-token').val()
          username: $('#create-account-service-username').val()

    log "Submitting Login with the data:",
      data: data

    mediator.publish 'socket:msg', data

    @model.login data, ->

      mediator.publish 'auth:success', data

  showCreateAccountView: (e) ->
    e.preventDefault();
    mediator.publish 'modal:redirect', 'join', @
