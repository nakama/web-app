module.exports = function(app, config, DIR, express, hbs, path, util) {
	//app.error(raven.middleware.express('https://8592bbebebb8415facaa2b192871c2a1:d4d68ac170d84b909ea27b7b53e03ac4@app.getsentry.com/3302'));

	app.configure(function() {

		app.set('views', path.join(DIR, '/views'));
		app.set('view engine', 'hbs');
		app.engine('hbs', hbs.__express);

		app.use(express.favicon());
		app.use(express.logger('dev'));

		app.use(express.query());
		app.use(express.bodyParser());
		app.use(express.cookieParser(config.app.cookie_secret));
		app.use(express.methodOverride());
		
		app.use(express.session());
		app.use(express.csrf());
		app.use(function(req, res, next){
			res.locals.token = req.session._csrf;
			next();
		});

		// This is not needed if you handle static files with, say, Nginx (recommended in production!)
		// Last, but not least: Express' default error handler is very useful in dev, but probably not in prod.
		//if ((typeof process.env['NODE_SERVE_STATIC'] !== 'undefined') && process.env['NODE_SERVE_STATIC'] == 1) {
			util.log("Serving static files through node.js at: ");
			var static = path.join(DIR, config.app.static)
			console.log(static);
			app.use(express.static(static));
			app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
		//}
		
		app.use(app.router);

		// Catch-all error handler. Override as you see fit
		app.use(function(err, req, res, next) {
			console.error(err.stack);
			res.send(500, 'An unexpected error occurred! Please check logs.');
		});
	});
}