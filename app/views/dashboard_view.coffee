template = require 'views/templates/home'
PageView = require 'views/base/page_view'

module.exports = class DashboardView extends PageView
	template: template
	className: 'dashboard-page'
