{mediator} = require 'common'
ModalView = require 'views/base/modal'
template  = require 'views/templates/join'

module.exports = class JoinView extends ModalView
  template: template
  container: 'body'
  autoRender: true
  id: "view-join-modal"

  events:
    'click #modal-submit': 'modalSubmit'

  initialize: (data) ->
    super
    console.log("Initializing the Join View");
    
  modalSubmit: (e) ->
    e.preventDefault();

    data = 
      name: $('#create-account-name').val()
      email: $('#create-account-email').val()
      username: $('#create-account-username').val()
      password: $('#create-account-password').val()

    console.log "Submitting form with the data:", data

    @model.create data, (data) ->
      console.log "Join data response", data

      mediator.publish 'auth:success', @