View     = require 'views/base/view'
template = require 'views/templates/photo_collection_item'

module.exports = class PhotoCollectionItemView extends View
  template: template
  autoRender: false

  initialize: ->
    super
    console.log 'PhotoCollectionItemView#initialize'

  render: ->
    super
    console.log 'render', @
    # console.log @$el.parent(), @
    # console.log @template
    this