Controller        = require 'controllers/base/controller'
LoginView         = require 'views/login'
User              = require 'models/user'

module.exports = class HomeController extends Controller
  historyURL: ''

  index: ->
    console.log 'Loading Login View'

    @user = new User
    @view = new LoginView
    	model: @user
