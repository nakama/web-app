{log}            = require 'lib/logger'
mediator       = require 'mediator'
ModalView      = require 'views/base/modal'
template       = require 'views/templates/connect'

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
      #$('#login-services-custom').hide()
    
  #### Connect Facebok
  # Attempt to connect a user to Nakama using Facebook
  #
  # `e` should be an `Object`

  connectFacebook: (e) ->
    e?.preventDefault()

    user = @model
    view = @

    user.connectFacebook (exists, res, token) =>
      log "Connecting to Facebook..."
        res: res

      # User exists
      if exists
        res.object.services.facebook.auth_token = token
        mediator.publish 'auth:success', res.object, view

      # Assume new user
      else
        @createNewUser 'facebook', res, (result) ->
          mediator.publish 'auth:success', result.object, view

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
        @createNewUser 'facebook', res, (result) ->
          mediator.publish 'auth:success', result.object, view

  #### Create a new user
  #
  
  createNewUser: (service, res, callback) ->
    log "Create new user",
      res: res

    user = @model

    $name     = $('#create-account-name')
    $email    = $('#create-account-email')
    $username = $('#create-account-username')
    $avatar   = $('#create-account-avatar')

    $('#login-services-wrapper').hide()
    $('#login-services-extra').show()
    $('#modal-submit').text('Submit')

    data = {}
    data.session = {}

    # Need to keep things separated by service
    unless data.session
      data.session = {}

    unless data.session.profile_picture
      data.session.profile_picture = ""

    unless data.session.full_name
      data.session.full_name = ""

    if service is 'facebook'
      data.session.auth_token = res.authResponse.accessToken
      data.session.id         = res.authResponse.userID

    if service is 'instagram'
      data.session.auth_token = res.session.access_token

    avatar = data.session.profile_picture
    name   = data.session.full_name

    $avatar.val(avatar)
    $name.val(name)

    $('#modal-submit').on 'click', (e) ->
      e.preventDefault()

      data.username = $username.val()
      data.name     = $name.val()
      data.email    = $email.val()

      user.createByService service, data, (result) ->
        # On first login, fetch the photos from services
        mediator.publish 'api', 'photos:fetch', {user: mediator.user.toJSON()}
        callback(result)

  ###
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

    #mediator.publish 'socket:msg', data

    @model.login data, ->

      mediator.publish 'auth:success', data
  ###

  showCreateAccountView: (e) ->
    e.preventDefault();
    mediator.publish 'modal:redirect', 'join', @
