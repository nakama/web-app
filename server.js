// - Dependencies
var config  = require('./config/app'),
	express = require('express'),
	app     = express(),
	routes  = require('./config/routes'),
	fs      = require('fs'),
	hbs     = require('hbs'),
	mime    = require('mime'),
	path    = require('path'),
	_       = require('underscore'),
	util    = require('util')

// - Server Settings
require('./config/express')(app, config, __dirname, express, hbs, path, util);

// - Routes
app.get('*', routes.index);

// - Start Up Server
require('./config/startup')(_, app, config, process, util);