View     = require 'views/base/view'
Photo    = require 'models/photo'
template = require 'views/templates/photo'

module.exports = class PhotoView extends View
  template: template
  container: '#page-container'
  autoRender: true
  tagName: 'li'
  className: 'photo-wrapper'

  initialize: (data) ->
    super
    console.log "Photo Data"
    console.log data
