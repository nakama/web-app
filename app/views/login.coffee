ModalView = require 'views/base/modal'
template  = require 'views/templates/login'

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
    console.log "hit"
    window.location.href = '/dashboard'

  showCreateAccountView: (e) ->
    e.preventDefault();
    window.location.href = '/join'