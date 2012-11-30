module.exports = (match) ->
	match '',          'home#connect'
	match 'oauth',     'home#oauth'
	#match 'join',      'home#join'
	#match 'login',     'home#login'

	match 'dashboard', 'dashboard#index'
