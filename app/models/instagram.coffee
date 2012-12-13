{api, log, mediator, Model} = require 'common'

module.exports = class Instagram extends Model

	initialize: ->
		super

	#### Login using the Instagram Javascript SDK
	#
	# `callback` should be a `Function`
	#

	login: (callback) ->
		
		# Expect `res` to be an `Object`
		IG.login(
			(res) ->
				if res.session
					callback(res)
				else
					callback(res, err)
			scope: ['comments', 'likes']
		)
