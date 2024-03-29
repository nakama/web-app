exports.config =
  # See http://brunch.readthedocs.org/en/latest/config.html for documentation.
  files:
    javascripts:
      joinTo:
        'js/app.js': /^app/
        'js/vendor.js': /^vendor/
        'test/js/test.js': /^test(\/|\\)(?!vendor)/
        'test/js/test-vendor.js': /^test(\/|\\)(?=vendor)/
      order:
        # Files in `vendor` directories are compiled before other files
        # even if they aren't specified in order.before.
        before: [
          'vendor/scripts/console-helper.js',
          'vendor/scripts/jquery-ui-1.9.2.custom.js',
          'vendor/scripts/underscore-1.4.0.js',
          'vendor/scripts/backbone-0.9.2.js',
          'vendor/scripts/backbone.validation.js',
          'vendor/scripts/chaplin-0.6.0-pre-299623f.js',
          'vendor/scripts/bootstrap.js',
          'vendor/scripts/isotope-1.5.9.min.js'
        ]

    stylesheets:
      joinTo:
        'css/app.css': /^(app|vendor)/
        'test/css/test.css': /^test/
      order:
        before: [
          'vendor/styles/bootstrap.min.css',
          'vendor/styles/bootstrap-responsive.min.css',
          'vendor/styles/isotope.css'
        ]
        after: ['vendor/styles/helpers.css']

    templates:
      joinTo: 'js/app.js'
