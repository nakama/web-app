{log, mediator} = require 'common'
ModalView       = require 'views/base/modal'
template        = require 'views/templates/connect'

module.exports = class OAuthView extends ModalView
  template: template
  container: 'body'
  autoRender: true
  id: "view-oauth"

  events:
    'click #modal-submit'              : 'onSubmit'

  initialize: (data) ->
    super
    log "Initializing the OAuth View",
      model: @model
    
  afterRender: ->
    super

    # Right now only instragram comes here


  onSubmit: (e) =>
    e.preventDefault();
    
    data = 
      username: $('#auth-username').val()
      password: null
      profile:
        avatar: ""
        email: ""
        name: ""
      services:
        instragram:
          auth_token: ""
          id: ""

    log "Submitting OAuth Login with the data:",
      data: data
    return
    mediator.publish 'socket:msg', data

    @model.login data, ->

      mediator.publish 'auth:success', data
