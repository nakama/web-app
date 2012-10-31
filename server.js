// - Dependencies
var config  = require('./config/app'),
	express = require('express'),
	app     = express(),
	routes  = require('./config/routes'),
	//cluster = require('cluster')
	fs      = require('fs'),
	gzippo  = require('gzippo'),
	hbs     = require('hbs'),
	mime    = require('mime'),
	path    = require('path'),
	raven   = require('raven'),
	_       = require('underscore'),
	util    = require('util')

// - Server Settings
require('./config/express')(app, config, __dirname, express, gzippo, hbs, path, raven, util);

// - Routes
//app.get('/', routes.index);
app.all('*', function(req, res) {

	var path = req.url,
		type = mime.lookup(path)

	if (type != "application/octet-stream") {
		var charset = mime.charsets.lookup(type);

		res.setHeader('Content-Type', type + (charset ? '; charset=' + charset : ''));
		path = "public" + path;
		fs.readFile(path, "utf8", function(err, data) {
		    if (err) {
		    	res.send(404)
		    } else {
		    	res.send(data)
		    }
	    });
		return;
	}

	res.render('index');
});

// - Start Up Server
require('./config/startup')(_, app, config, process, util);