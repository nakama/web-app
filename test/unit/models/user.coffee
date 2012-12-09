{Model}   = require 'chaplin'
User = require 'models/user'

describe 'User Model', ->
	
	beforeEach ->
		@model = new User()

	afterEach ->
		@model.dispose()

	describe 'Structure', ->

		it 'should extend Chaplin\'s Model', ->
			expect(@model).to.be.a Object
			expect(@model).to.be.a Model

		it 'should have a property initialize', ->
			expect(@model).to.have.property('initialize')
			expect(@model.initialize).to.be.a Function

		it 'should have a property connectFacebook', ->
			expect(@model).to.have.property('connectFacebook')
			expect(@model.connectFacebook).to.be.a Function

		it 'should have a property connectInstagram', ->
			expect(@model).to.have.property('connectInstagram')
			expect(@model.connectInstagram).to.be.a Function

		it 'should have a property create', ->
			expect(@model).to.have.property('create')
			expect(@model.create).to.be.a Function

		it 'should have a property delete', ->
			expect(@model).to.have.property('delete')
			expect(@model.delete).to.be.a Function

		it 'should have a property find', ->
			expect(@model).to.have.property('find')
			expect(@model.find).to.be.a Function

		it 'should have a property login', ->
			expect(@model).to.have.property('login')
			expect(@model.login).to.be.a Function

		it 'should have a property loginFacebook', ->
			expect(@model).to.have.property('loginFacebook')
			expect(@model.loginFacebook).to.be.a Function

		it 'should have a property loginInstagram', ->
			expect(@model).to.have.property('loginInstagram')
			expect(@model.loginInstagram).to.be.a Function

		it 'should have a property update', ->
			expect(@model).to.have.property('update')
			expect(@model.update).to.be.a Function

	describe 'Find', ->

		it 'should be able to find user by ID', (done) ->
			@model.find '24989575694867494587980951453', (data) ->
				console.log data
				done()

		it 'should be able to find user by ID (explicit)', (done) ->
			params = 
				id: '24989575694867494587980951453'

			@model.find params, (data) ->
				console.log data
				done()

		it 'should be able to find user by Instagram ID', (done) ->
			params = 
				service: 'instagram'
				identifier: 'id'
				value: '18632811'

			@model.find params, (data) ->
				console.log data
				done()

	describe 'Login', ->

		it 'should be able to login a user', (done) ->
			params =
				username: 'chris'
				password: 'F4stp4ss'

			@model.login params, (data) ->
				console.log data
				done()
