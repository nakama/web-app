// - Dependencies
var config  = require('./config/app'),
	io      = require('socket.io'),
	express = require('express'),
	app     = express(),
	server  = require('http').createServer(app),
	io      = io.listen(server),
	routes  = require('./config/routes'),
	fs      = require('fs'),
	hbs     = require('hbs'),
	path    = require('path'),
	_       = require('underscore'),
	util    = require('util'),
	redis   = require("redis")

// - Redis pubsub
subscribe  = redis.createClient(config.app.redis.port, config.app.redis.host);
publish    = redis.createClient(config.app.redis.port, config.app.redis.host);
var clients = {};
//var subsribe = {};
//var publish = {};

var createClient = function(channel) {
	clients[channel] = redis.createClient(config.app.redis.port, config.app.redis.host);
};

// - Server Settings
require('./config/express')(app, config, __dirname, express, hbs, path, util);

// - Routes
app.get('*', routes.index);

// - Start Up Server
require('./config/startup')(_, app, config, process, server, util);

io.sockets.on('connection', function (socket) {
	
	//Client sent a message, do something with it
	socket.on('server:msg', function (data) {
		console.log("Server received message:", data);
		socket.emit('msg', "Got your message bro!")
		//publish.publish("test132", "I am sending a message.");
    });

	//Client requests photos for user
    socket.on('api:photos:fetch', function(user) {

    	user.services.facebook = {
    		auth_token: "AAADRIjXsxIABACmYIkXOYpvLz2U03YCKRSjqquK3YZAEeyjnLvJGCvoAgwAxYR2OP63Ug36N401CGUL9ktttc6oqsECavoCg02hr4wAZDZD"
    	}

    	var data = {
			action: "fetch",
			callback: "photoFetchReturn",
			request: {
				user: user
			}
		}

    	data = JSON.stringify(data)

    	console.log('api:photos:fetch')
    	console.log(data)
    	console.log('')

    	publish.publish('photo', data);
    	subscribe.subscribe("photoFetchReturn");

		subscribe.on("message", function (channel, message) {
	  		console.log("redis client received msg " + channel + ": " + message);
	        socket.emit('msg', message)

	        var listData = {
				action: "list",
				callback: "photoReturn",
				request: {
					user: {
						id: user.id
					}
				}
			}

			listData = JSON.stringify(listData)

			console.log('api:photos:list')
	    	console.log(listData)
	    	console.log('')

	    	publish.publish('photo', listData);
	    	subscribe.subscribe("photoReturn");

			subscribe.on("message", function (channel, message) {
		  		console.log("redis client received msg ")
		  		console.log(message);
		        //socket.emit('msg', message)
		        message = JSON.parse(message)
		        message.api = 'api:photos:fetched'
		        socket.emit('msg', message)
			});
		});
    });

	//List photos for client
	socket.on('api:photos:list', function(user) {
		var listData = {
			action: "list",
			callback: "photoReturn",
			request: {
				user: {
					id: user.id
				}
			}
		}

		listData = JSON.stringify(listData)

		console.log('api:photos:list')
    	console.log(listData)
    	console.log('')

    	publish.publish('photo', listData);
    	subscribe.subscribe("photoReturn");

		subscribe.on("message", function (channel, message) {
	  		console.log("redis client received msg ")
	  		console.log(message);
	        //socket.emit('msg', message)
	        message = JSON.parse(message)
	        message.api = 'api:photos:fetched'
	        socket.emit('msg', message)
		});
	})
});

/*
subscribe.subscribe("test132");

subscribe.on("error", function (err) {
    console.log("Redis says: " + err);
});

subscribe.on("ready", function () {
    console.log("Redis Signup ready.");
});

subscribe.on("reconnecting", function (arg) {
    console.log("Redis reconnecting: " + JSON.stringify(arg));
});
subscribe.on("connect", function () {
    console.log("Redis connected to channel: ");
});

subscribe.on("subscribe", function () {
    console.log("Redis subscribe to channel: ");
});

subscribe.on("unsubscribe", function () {
    console.log("Redis unsubscribe to channel: ");
    subscribe.end();
});
*/