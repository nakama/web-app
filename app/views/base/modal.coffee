{View} = require('common')

module.exports = class ModalView extends View
  container: 'body'
  className: 'modal hide fade'
  attributes:
    role: 'dialog'
    'aria-hidden': true
    'tabindex': '-1'

  defaults:
    isModal: yes
    size: 'normal'

  afterRender: ->
    # Setup automatic disposal
    @$el.on 'hidden', $.proxy(@dispose, @)

    @$el.addClass 'size-' + @options.size

    # Show it
    @$el.modal('show')
