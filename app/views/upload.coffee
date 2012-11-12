ModalView = require 'views/base/modal'
template  = require 'views/templates/upload'

module.exports = class UploadView extends ModalView
	autoRender: true
	container: '#master-upload'
	id: 'view-upload'
	tempate: template
	#persistant: yes

	initialize: ->
		super
		console.log "Initializing the Upload View"
