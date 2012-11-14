module.exports = (match) ->
  match '',          'home#index'
  match 'dashboard', 'dashboard#index'
  match 'join',      'auth#join'
