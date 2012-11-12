Chaplin  = require 'chaplin'
logger   = require 'lib/logger'

module.exports = common =
	mediator : Chaplin.mediator

	error    : logger.error
	log      : logger.log
	warn     : logger.warn


	Application    : require 'application'
	Collection     : require 'models/base/collection'
	CollectionView : require 'views/base/collection_view'
	Controller     : require 'controllers/base/controller'
	Model          : require 'models/base/model'
	PageView       : require 'views/base/page_view'
	View           : require 'views/base/view'
