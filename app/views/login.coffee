{log, mediator} = require 'common'
ModalView       = require 'views/base/modal'
template        = require 'views/templates/login'

module.exports = class LoginView extends ModalView
  template: template
  container: 'body'
  autoRender: true
  id: "view-login-modal"

  events:
    'click #modal-submit': 'onSubmit'
    'click a[href="#create-account"]': 'showCreateAccountView'

  initialize: (data) ->
    super
    log "Initializing the Login View",
      model: @model

    Backbone.Validation.bind(this)
    
  onSubmit: (e) =>
    e.preventDefault();
    
    data = 
      username: $('#auth-username').val()
      password: $('#auth-password').val()

    log "Submitting Login with the data:",
      data: data

    @model.validate 'username'

    @model.bind 'validated:valid', (model) =>
      log "Validation succeeded"

      @model.login data, (data) ->
        log "Login data response", data

        mediator.publish 'auth:success', @

    @model.bind 'validated:invalid', (model, errors) ->
      log "Validation failed:",
        errors: errors
        model: model

      mediator.publish 'modal:error', errors, @

      _.each errors, (str, field) ->
        log "Looping through errors",
          field: field
          str: str
          jfield: $("input[name=#{field}]")

        #$("input[name=#{field}]").after("<p>#{str}</p>")
        $("input[name=#{field}]").tooltip
          trigger: 'manual'
          placement: 'right'

  showCreateAccountView: (e) ->
    e.preventDefault();
    mediator.publish 'modal:redirect', 'join', @
