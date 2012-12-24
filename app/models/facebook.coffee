api       = require 'lib/api'
{log}            = require 'lib/logger'
mediator  = require 'mediator'
Model     = require 'models/base/model'

module.exports = class Facebook extends Model

	initialize: ->
		super

	#### Login using the Facebook Javascript SDK
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
