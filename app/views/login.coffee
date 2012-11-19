{log, mediator} = require 'common'
ModalView       = require 'views/base/modal'
template        = require 'views/templates/login'

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
    log "Initializing the Login View",
      model: @model

    Backbone.Validation.bind(this)
    
  modalSubmit: (e) =>
    e.preventDefault();
    
    data = 
      username: $('#auth-username').val()
      password: $('#auth-password').val()

    log "Submitting Login with the data:",
      data: data

    @model.validate 'username'

    @model.bind 'validated:invalid', (model, errors) ->
      log "Validation failed:",
        errors: errors
        model: model

      _.each errors, (str, field) ->
        log "Looping through errors",
          field: field
          str: str
          jfield: $("input[name=#{field}]")

        $("input[name=#{field}]").after("<p>#{str}</p>")

    @model.login data, (data) ->
      console.log "Login data response", data

      mediator.publish 'auth:success', @

  showCreateAccountView: (e) ->
    e.preventDefault();
    mediator.publish 'modal:redirect', 'join', @
