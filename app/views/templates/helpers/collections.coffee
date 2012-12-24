Handlebars.registerHelper 'allPhotos', (collection, options) ->

	i = 0
	l = items.length

	while i < l
		out = out + "<li>" + options.fn(items[i]) + "</li>"
		i++

	out

Handlebars.registerHelper 'firstPhoto', (photos, options) ->

	console.log "*****************", photos

	options.fn({photo: photos[0]})
