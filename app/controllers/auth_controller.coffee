{mediator} = require 'common'
User = require 'models/user'

module.exports = class AuthController extends Controller
	mediator.user = new User()