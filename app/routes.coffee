module.exports = (match) ->
	match '',          'auth#login'
	match 'dashboard', 'dashboard#index'
	match 'join',      'auth#join'
	match 'login',     'auth#login'