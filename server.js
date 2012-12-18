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

	//Fetch photos
    socket.on('api:photos:fetch', function(res) {

    	var data = {
			action: "fetch",
			callback: "photoFetchReturn",
			request: res
		}

    	data = JSON.stringify(data)

    	console.log('api:photos:fetch')
    	console.log(data)
    	console.log('')

    	publish.publish('photo', data);
    	subscribe.subscribe("photoFetchReturn");

		subscribe.on("message", function (channel, message) {
	  		console.log("redis client received msg " + channel + ": " + message);
	        
	        message = JSON.parse(message)
	        message.api = 'api:collections:fetched'
	        socket.emit('msg', message)
		});
    });

	//List collections
	socket.on('api:photos:collections', function(res) {
		var listData = {
			action: "list",
			callback: "photoReturnCollections",
			request: res
		}

		listData = JSON.stringify(listData)

		console.log('api:photos:collections')
    	console.log(listData)
    	console.log('')

    	publish.publish('photo', listData);
    	subscribe.subscribe("photoReturnCollections");

		subscribe.on("message", function (channel, message) {
	  		console.log("redis client received msg ")
	  		console.log(message);
	        //socket.emit('msg', message)
	        message = JSON.parse(message)
	        message.api = 'api:photos:collections:fetched'
	        socket.emit('msg', message)
		});
	});

	//List photos of a collection
	socket.on('api:photos:list', function(res) {
		var listData = {
			action: "list",
			callback: "photoReturnList",
			request: res
		}

		listData = JSON.stringify(listData)

		console.log('api:photos:list')
    	console.log(listData)
    	console.log('')

    	publish.publish('photo', listData);
    	subscribe.subscribe("photoReturnList");

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