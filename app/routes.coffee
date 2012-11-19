module.exports = (match) ->
  match '',          'auth#index'
  match 'dashboard', 'dashboard#index'
  match 'join',      'auth#join'
