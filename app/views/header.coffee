View = require 'views/base/view'
template    = require 'views/templates/header'

module.exports = class HeaderView extends View
    autoRender: true
    className: "navbar-inner"
    container: 'body'
    containerMethod: 'prepend'
    tagName: 'header'
    template: template

    initialize: ->
        super
        console.log("Initializing the Header View");

        