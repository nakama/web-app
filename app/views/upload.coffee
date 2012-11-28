{log, ModalView} = require 'common'
template         = require 'views/templates/upload'

module.exports = class UploadView extends ModalView
	autoRender: true
	container: '#master-upload'
	id: 'view-upload'
	template: template
	#persistant: yes

	events:
		'click a[href="#connectfacebook"]': 'connectFacebook'

	initialize: ->
		super
		console.log "Initializing the Upload View"

	connectFacebook: (e) ->
		e.preventDefault()

		log "hit"

		FB.login (response) ->
			if response.authResponse
				# connected
					log "Connected to Facebook",
						response: response
			
			else
				# cancelled
		, {scope:'user_photos,offline_access'}