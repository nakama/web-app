{log, mediator} = require 'common'
ModalView = require 'views/base/modal'
template  = require 'views/templates/login'
User = require 'models/user'

module.exports = class LoginView extends ModalView
  template: template
  container: 'body'
  autoRender: true
  id: "view-login-modal"

  events:
    'click #modal-submit': 'modalSubmit'
    'click a[href="#create-account"]': 'showCreateAccountView'

  initialize: (data) ->
    super
    console.log("Initializing the Login View");
    
  modalSubmit: (e) =>
    e.preventDefault();
    
    data = 
      username: $('#auth-username').val()
      password: $('#auth-password').val()

    log "Submitting Login with the data:",
      data: data

    @model.login data, (data) ->
      console.log "Login data response", data

      mediator.publish 'auth:success', @

  showCreateAccountView: (e) ->
    e.preventDefault();
    mediator.publish 'modal:redirect', 'join', @
