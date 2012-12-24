module.exports = (match) ->
	match '',          'home#connect'
	#match 'join',      'home#join'
	#match 'login',     'home#login'

	match ':username/collections', 'dashboard#collections'
	match 'dashboard',             'dashboard#index'
