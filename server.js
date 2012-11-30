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
	redis   = require("redis"),
	

// - Redis pubsub
subscribe  = redis.createClient(config.app.redis.port, config.app.redis.host);
publish  = redis.createClient(config.app.redis.port, config.app.redis.host);


// - Server Settings
require('./config/express')(app, config, __dirname, express, hbs, path, util);

// - Routes
app.get('*', routes.index);

// - Start Up Server
require('./config/startup')(_, app, config, process, server, util);

io.sockets.on('connection', function (socket) {
	socket.on('server:msg', function (data) {
		console.log("Server received message:", data);
		socket.emit('msg', "Got your message bro!")
		publish.publish("test132", "I am sending a message.");
    });
});

subscribe.subscribe("test132"); 
subscribe.on("message", function (channel, message) {
  		console.log("redis client received msg " + channel + ": " + message);
        socket.emit('msg', message)
});

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

