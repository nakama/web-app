View = require 'views/base/view'
template = require 'views/templates/header'

module.exports = class HeaderView extends View
  template: template
  id: 'navigation'
  className: 'navbar navbar-fixed-top'
  container: '#header-container'
  autoRender: true

  initialize: ->
    super
    @subscribeEvent 'loginStatus', @render
    @subscribeEvent 'startupController', @render
