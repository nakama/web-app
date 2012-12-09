/*global module:false*/
module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg: '<json:package.json>',
    meta: {
      banner: '/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - ' +
        '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
        '<%= pkg.homepage ? "* " + pkg.homepage + "\n" : "" %>' +
        '* Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>;' +
        ' Licensed <%= _.pluck(pkg.licenses, "type").join(", ") %> */'
    },

    vendor: {
      scripts: {
        before: [
          'vendor/scripts/console-helper.js',
          'vendor/scripts/underscore-1.4.0.js',
          'vendor/scripts/backbone-0.9.2.js'
        ]
      }
    },

    coffee: {
      compile: {
        files: {
          'tmp/*.js' : 'app/**/*.coffee'
        }
      }
    },

    handlebars: {
      compile: {
        options: {
          namespace: "JST"
        },
        files: {
          "tmp/templates/": "app/templates/**/*.hbs"
        }
      }
    },

    concat: {
      css: {
        src: [
          'tmp/styles/bootstrap.css',
          'tmp/styles/responsive.css',
          'vendor/styles/helper.css',
          'vendor/styles/select2.css',
          'tmp/styles/stylus.css'
        ],
        dest: 'test/css/app.css'
      },
      js: {
        src: [
          //'vendor/scripts/before/require_definition.js',
          '<config:vendor.scripts.before>',
          'vendor/scripts/*.js',
          'wrap/*.js',
          'wrap/**/*.js',
          'test/js/unit/**/*.js'
        ],
        dest: 'test/js/app.js'
      }
    },

    wrap: {
      modules: {
        excludeBase: 'tmp/',
        src: ['tmp/**/*.js'],
        dest: 'wrap/',
        wrapper: function(path, data) {
          var str = ''
          str += 'window.require.define({"' + path + '": function(exports, require, module) {\n'
          str += data
          str += '}});'
          return str;
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-handlebars');
  grunt.loadNpmTasks("grunt-wrap");

  grunt.registerTask('default', '');
  grunt.registerTask('t', 'coffee handlebars wrap concat');
};
