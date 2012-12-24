module.exports = (options, callback) ->

	data = if options.data then JSON.stringify(options.data) else null
	set  = options.set or yes
	type = options.type or 'POST'
	url  = 'http://ec2-23-23-8-2.compute-1.amazonaws.com:8080' + options.url

	ajaxOptions = 
		contentType : 'application/json'
		type        : type
		url         : url
		data        : data

		success: (data, status, jqxhr) =>
			log 'API call successful',
				arguments: arguments

			if set
				@set options.data

			if typeof callback is 'function'
				callback(data, status, jqxhr)

		error: ->
			log 'API call failed',
				arguments: arguments

	log 'API call initialized',
		options: options
		ajaxOptions: ajaxOptions

	$.ajax ajaxOptions
