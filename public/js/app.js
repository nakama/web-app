(function(/*! Brunch !*/) {
  'use strict';

  var globals = typeof window !== 'undefined' ? window : global;
  if (typeof globals.require === 'function') return;

  var modules = {};
  var cache = {};

  var has = function(object, name) {
    return ({}).hasOwnProperty.call(object, name);
  };

  var expand = function(root, name) {
    var results = [], parts, part;
    if (/^\.\.?(\/|$)/.test(name)) {
      parts = [root, name].join('/').split('/');
    } else {
      parts = name.split('/');
    }
    for (var i = 0, length = parts.length; i < length; i++) {
      part = parts[i];
      if (part === '..') {
        results.pop();
      } else if (part !== '.' && part !== '') {
        results.push(part);
      }
    }
    return results.join('/');
  };

  var dirname = function(path) {
    return path.split('/').slice(0, -1).join('/');
  };

  var localRequire = function(path) {
    return function(name) {
      var dir = dirname(path);
      var absolute = expand(dir, name);
      return globals.require(absolute);
    };
  };

  var initModule = function(name, definition) {
    var module = {id: name, exports: {}};
    definition(module.exports, localRequire(name), module);
    var exports = cache[name] = module.exports;
    return exports;
  };

  var require = function(name) {
    var path = expand(name, '.');

    if (has(cache, path)) return cache[path];
    if (has(modules, path)) return initModule(path, modules[path]);

    var dirIndex = expand(path, './index');
    if (has(cache, dirIndex)) return cache[dirIndex];
    if (has(modules, dirIndex)) return initModule(dirIndex, modules[dirIndex]);

    throw new Error('Cannot find module "' + name + '"');
  };

  var define = function(bundle) {
    for (var key in bundle) {
      if (has(bundle, key)) {
        modules[key] = bundle[key];
      }
    }
  }

  globals.require = require;
  globals.require.define = define;
  globals.require.brunch = true;
})();

window.require.define({"collections/photos": function(exports, require, module) {
  var Collection, Photo, Photos,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Collection = require('models/base/collection');

  Photo = require('models/photo');

  module.exports = Photos = (function(_super) {

    __extends(Photos, _super);

    function Photos() {
      return Photos.__super__.constructor.apply(this, arguments);
    }

    Photos.prototype.model = Photo;

    Photos.prototype.url = '/photos.json';

    return Photos;

  })(Collection);
  
}});

window.require.define({"common": function(exports, require, module) {
  var Chaplin, common, logger;

  Chaplin = require('chaplin');

  logger = require('lib/logger');

  module.exports = common = {
    mediator: Chaplin.mediator,
    error: logger.error,
    log: logger.log,
    warn: logger.warn,
    Collection: require('models/base/collection'),
    CollectionView: require('views/base/collection_view'),
    Controller: require('controllers/base/controller'),
    Model: require('models/base/model'),
    PageView: require('views/base/page_view'),
    View: require('views/base/view'),
    Application: Chaplin.Application.extend({
      title: 'Nakama',
      initialize: function() {
        var routes;
        $.ajaxSetup({
          cache: false,
          dataType: 'json'
        });
        this.initTemplateHelpers();
        this.initDispatcher();
        this.initLayout();
        this.initControllers();
        routes = require('routes');
        this.initRouter(routes);
        return typeof Object.freeze === "function" ? Object.freeze(this) : void 0;
      },
      initLayout: function() {
        var Layout;
        Layout = require('views/layout');
        return this.layout = new Layout({
          title: this.title
        });
      },
      initTemplateHelpers: function() {},
      initControllers: function() {
        var AuthController;
        AuthController = require('controllers/auth_controller');
        return this.auth = new AuthController;
      },
      initMediator: function() {
        return mediator.user = null;
      }
    })
  };
  
}});

window.require.define({"controllers/auth_controller": function(exports, require, module) {
  var AuthController, Controller, JoinView, User, mediator, _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  _ref = require('common'), Controller = _ref.Controller, mediator = _ref.mediator;

  User = require('models/user');

  JoinView = require('views/join');

  module.exports = AuthController = (function(_super) {

    __extends(AuthController, _super);

    function AuthController() {
      return AuthController.__super__.constructor.apply(this, arguments);
    }

    AuthController.prototype.initialize = function() {
      AuthController.__super__.initialize.apply(this, arguments);
      return this.user = mediator.user = new User;
    };

    AuthController.prototype.join = function() {
      return new JoinView({
        model: new User
      });
    };

    return AuthController;

  })(Controller);
  
}});

window.require.define({"controllers/base/controller": function(exports, require, module) {
  var Chaplin, Controller,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Chaplin = require('chaplin');

  module.exports = Controller = (function(_super) {

    __extends(Controller, _super);

    function Controller() {
      return Controller.__super__.constructor.apply(this, arguments);
    }

    Controller.prototype.initialize = function() {
      var _this = this;
      Controller.__super__.initialize.apply(this, arguments);
      if (this.events) {
        return _(this.events).each(function(fn_name, event_name) {
          if (typeof _this[fn_name] === 'function') {
            return Chaplin.mediator.subscribe(event_name, $.proxy(_this[fn_name], _this));
          } else {
            console.log("The listener for " + event_name + " (@" + fn_name + ") doesn't exist.");
            return console.log("@[" + fn_name + "]", _this[fn_name]);
          }
        });
      }
    };

    return Controller;

  })(Chaplin.Controller);
  
}});

window.require.define({"controllers/dashboard_controller": function(exports, require, module) {
  var Controller, DashboardController, PhotoCollection, PhotoCollectionView, log, logger,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Controller = require('controllers/base/controller');

  PhotoCollection = require('collections/photos');

  PhotoCollectionView = require('views/photo_collection_view');

  logger = require('lib/logger');

  log = logger.log;

  module.exports = DashboardController = (function(_super) {

    __extends(DashboardController, _super);

    function DashboardController() {
      return DashboardController.__super__.constructor.apply(this, arguments);
    }

    DashboardController.prototype.historyURL = 'dashboard';

    DashboardController.prototype.index = function() {
      log('Loading Photo Collection');
      this.collection = new PhotoCollection;
      this.view = new PhotoCollectionView({
        collection: this.collection
      });
      return this.view.collection.fetch();
    };

    return DashboardController;

  })(Controller);
  
}});

window.require.define({"controllers/header_controller": function(exports, require, module) {
  var Controller, HeaderController, HeaderView, User,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Controller = require('controllers/base/controller');

  HeaderView = require('views/header');

  User = require('models/user');

  module.exports = HeaderController = (function(_super) {

    __extends(HeaderController, _super);

    function HeaderController() {
      return HeaderController.__super__.constructor.apply(this, arguments);
    }

    HeaderController.prototype.initialize = function() {
      HeaderController.__super__.initialize.apply(this, arguments);
      console.log('Loading Header View');
      this.user = new User;
      return this.view = new HeaderView({
        model: this.user
      });
    };

    return HeaderController;

  })(Controller);
  
}});

window.require.define({"controllers/home_controller": function(exports, require, module) {
  var Controller, HomeController, LoginView, User,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Controller = require('controllers/base/controller');

  LoginView = require('views/login');

  User = require('models/user');

  module.exports = HomeController = (function(_super) {

    __extends(HomeController, _super);

    function HomeController() {
      return HomeController.__super__.constructor.apply(this, arguments);
    }

    HomeController.prototype.historyURL = '';

    HomeController.prototype.index = function() {
      console.log('Loading Login View');
      this.user = new User;
      return this.view = new LoginView({
        model: this.user
      });
    };

    return HomeController;

  })(Controller);
  
}});

window.require.define({"initialize": function(exports, require, module) {
  var Application;

  Application = require('common').Application;

  $(function() {
    var app;
    console.log("Starting the application");
    app = new Application();
    return app.initialize();
  });
  
}});

window.require.define({"lib/logger": function(exports, require, module) {
  /*
    log 'This is a message',
      info: data
      otherthing: 'awesome'

    log data1, data2, data3

    warn 'Warning, this rocks', data1, warning_message: 'blah'

    error 'No way.'
  */

  var error, getOffset, indent, log, startTime, warn,
    __slice = [].slice;

  indent = 15;

  startTime = new Date().getTime();

  getOffset = function(label) {
    var length;
    if (label == null) {
      label = '';
    }
    length = indent - label.length + 1;
    if (length < 0) {
      length = 0;
    }
    return (new Array(length)).join(' ');
  };

  log = function() {
    var data, level, msg, time, timeDiff;
    msg = arguments[0], level = arguments[1], data = 3 <= arguments.length ? __slice.call(arguments, 2) : [];
    if (level == null) {
      level = 'log';
    }
    if (level !== 'log' && level !== 'warn' && level !== 'error') {
      data.unshift(level);
      level = 'log';
    }
    if (typeof msg !== 'string') {
      data.unshift(msg);
      msg = '';
    }
    time = new Date().getTime();
    timeDiff = (time - startTime) + 'ms';
    console[level](getOffset(timeDiff), timeDiff + ' ■', msg);
    return _(data).each(function(debug) {
      if (typeof debug === 'object') {
        return _(debug).each(function(value, key) {
          return console[level](getOffset(key), key, value);
        });
      }
    });
  };

  warn = function() {
    var data, msg;
    msg = arguments[0], data = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    return log.apply(null, [msg, 'warn'].concat(__slice.call(data)));
  };

  error = function() {
    var data, msg;
    msg = arguments[0], data = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    return log.apply(null, [msg, 'error'].concat(__slice.call(data)));
  };

  module.exports = {
    log: log,
    warn: warn,
    error: error
  };
  
}});

window.require.define({"models/base/collection": function(exports, require, module) {
  var Chaplin, Collection,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Chaplin = require('chaplin');

  module.exports = Collection = (function(_super) {

    __extends(Collection, _super);

    function Collection() {
      return Collection.__super__.constructor.apply(this, arguments);
    }

    return Collection;

  })(Chaplin.Collection);
  
}});

window.require.define({"models/base/model": function(exports, require, module) {
  var Chaplin, Model,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Chaplin = require('chaplin');

  module.exports = Model = (function(_super) {

    __extends(Model, _super);

    function Model() {
      return Model.__super__.constructor.apply(this, arguments);
    }

    return Model;

  })(Chaplin.Model);
  
}});

window.require.define({"models/photo": function(exports, require, module) {
  var Model, Photo,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Model = require('models/base/model');

  module.exports = Photo = (function(_super) {

    __extends(Photo, _super);

    function Photo() {
      return Photo.__super__.constructor.apply(this, arguments);
    }

    Photo.prototype.defaults = {
      author: null,
      data: null,
      location: null,
      path: null,
      stars: null,
      tags: []
    };

    Photo.prototype.initialize = function() {
      console.log("Initializing the Photo Model");
      return Photo.__super__.initialize.apply(this, arguments);
    };

    return Photo;

  })(Model);
  
}});

window.require.define({"models/user": function(exports, require, module) {
  var Model, User,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Model = require('models/base/model');

  module.exports = User = (function(_super) {

    __extends(User, _super);

    function User() {
      return User.__super__.constructor.apply(this, arguments);
    }

    User.prototype.initialize = function() {
      return User.__super__.initialize.apply(this, arguments);
    };

    User.prototype.create = function(options, callback) {
      console.log("Creating user...", options);
      return $.ajax({
        type: "POST",
        url: "http://50.19.65.14:8080/auth/user/add",
        data: options,
        success: function(data, status, jqxhr) {
          console.log("User creation successful", arguments);
          if (typeof callback === "function") {
            return callback(data, status, jqxhr);
          }
        },
        error: function() {
          return console.log("User creation failed", arguments);
        }
      });
    };

    User.prototype.login = function(options) {
      console.log("Logging in user...");
      return $.ajax({
        type: "POST",
        url: "http://50.19.65.14:8080/auth/user/login",
        data: options,
        success: function() {
          return console.log("User login successful", arguments);
        },
        error: function() {
          return console.log("User login failed", arguments);
        }
      });
    };

    return User;

  })(Model);
  
}});

window.require.define({"routes": function(exports, require, module) {
  
  module.exports = function(match) {
    match('', 'home#index');
    match('dashboard', 'dashboard#index');
    return match('join', 'auth#join');
  };
  
}});

window.require.define({"views/base/collection_view": function(exports, require, module) {
  var Chaplin, CollectionView, View,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Chaplin = require('chaplin');

  View = require('views/base/view');

  module.exports = CollectionView = (function(_super) {

    __extends(CollectionView, _super);

    function CollectionView() {
      return CollectionView.__super__.constructor.apply(this, arguments);
    }

    CollectionView.prototype.getTemplateFunction = View.prototype.getTemplateFunction;

    return CollectionView;

  })(Chaplin.CollectionView);
  
}});

window.require.define({"views/base/modal": function(exports, require, module) {
  var ModalView, View,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  View = require('views/base/view');

  module.exports = ModalView = (function(_super) {

    __extends(ModalView, _super);

    function ModalView() {
      return ModalView.__super__.constructor.apply(this, arguments);
    }

    ModalView.prototype.className = 'modal hide fade';

    ModalView.prototype.attributes = {
      role: 'dialog',
      'aria-hidden': true,
      'tabindex': '-1'
    };

    ModalView.prototype.defaults = {
      isModal: true,
      size: 'normal'
    };

    ModalView.prototype.afterRender = function() {
      this.$el.on('hidden', $.proxy(this.dispose, this));
      this.$el.addClass('size-' + this.options.size);
      return this.$el.modal('show');
    };

    return ModalView;

  })(View);
  
}});

window.require.define({"views/base/page_view": function(exports, require, module) {
  var PageView, View,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  View = require('views/base/view');

  module.exports = PageView = (function(_super) {

    __extends(PageView, _super);

    function PageView() {
      return PageView.__super__.constructor.apply(this, arguments);
    }

    PageView.prototype.container = '#page-container';

    PageView.prototype.autoRender = true;

    PageView.prototype.renderedSubviews = false;

    PageView.prototype.initialize = function() {
      var rendered,
        _this = this;
      PageView.__super__.initialize.apply(this, arguments);
      if (this.model || this.collection) {
        rendered = false;
        return this.modelBind('change', function() {
          if (!rendered) {
            _this.render();
          }
          return rendered = true;
        });
      }
    };

    PageView.prototype.renderSubviews = function() {};

    PageView.prototype.render = function() {
      PageView.__super__.render.apply(this, arguments);
      if (!this.renderedSubviews) {
        this.renderSubviews();
        return this.renderedSubviews = true;
      }
    };

    return PageView;

  })(View);
  
}});

window.require.define({"views/base/view": function(exports, require, module) {
  var Chaplin, View,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Chaplin = require('chaplin');

  module.exports = View = (function(_super) {

    __extends(View, _super);

    function View() {
      return View.__super__.constructor.apply(this, arguments);
    }

    View.prototype.getTemplateFunction = function() {
      return this.template;
    };

    return View;

  })(Chaplin.View);
  
}});

window.require.define({"views/dashboard_view": function(exports, require, module) {
  var DashboardView, PageView, template,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  template = require('views/templates/home');

  PageView = require('views/base/page_view');

  module.exports = DashboardView = (function(_super) {

    __extends(DashboardView, _super);

    function DashboardView() {
      return DashboardView.__super__.constructor.apply(this, arguments);
    }

    DashboardView.prototype.template = template;

    DashboardView.prototype.className = 'dashboard-page';

    return DashboardView;

  })(PageView);
  
}});

window.require.define({"views/header": function(exports, require, module) {
  var HeaderView, View, template,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  View = require('views/base/view');

  template = require('views/templates/header');

  module.exports = HeaderView = (function(_super) {

    __extends(HeaderView, _super);

    function HeaderView() {
      return HeaderView.__super__.constructor.apply(this, arguments);
    }

    HeaderView.prototype.autoRender = true;

    HeaderView.prototype.className = "navbar-inner";

    HeaderView.prototype.container = 'body';

    HeaderView.prototype.containerMethod = 'prepend';

    HeaderView.prototype.tagName = 'header';

    HeaderView.prototype.template = template;

    HeaderView.prototype.initialize = function() {
      HeaderView.__super__.initialize.apply(this, arguments);
      return console.log("Initializing the Header View");
    };

    return HeaderView;

  })(View);
  
}});

window.require.define({"views/join": function(exports, require, module) {
  var JoinView, ModalView, template,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  ModalView = require('views/base/modal');

  template = require('views/templates/join');

  module.exports = JoinView = (function(_super) {

    __extends(JoinView, _super);

    function JoinView() {
      return JoinView.__super__.constructor.apply(this, arguments);
    }

    JoinView.prototype.template = template;

    JoinView.prototype.container = 'body';

    JoinView.prototype.autoRender = true;

    JoinView.prototype.id = "view-join-modal";

    JoinView.prototype.events = {
      'click #modal-submit': 'modalSubmit'
    };

    JoinView.prototype.initialize = function(data) {
      JoinView.__super__.initialize.apply(this, arguments);
      return console.log("Initializing the Join View");
    };

    JoinView.prototype.modalSubmit = function(e) {
      var data;
      e.preventDefault();
      data = {
        name: $('#create-account-name').val(),
        email: $('#create-account-email').val(),
        username: $('#create-account-username').val(),
        password: $('#create-account-password').val()
      };
      console.log("Submitting form with the data:", data);
      return this.model.create(data, function(data) {
        console.log("Join data response", data);
        return window.location.href = '/dashboard';
      });
    };

    return JoinView;

  })(ModalView);
  
}});

window.require.define({"views/layout": function(exports, require, module) {
  var Chaplin, HeaderView, Layout, UploadView, User,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Chaplin = require('chaplin');

  User = require('models/user');

  HeaderView = require('views/header');

  UploadView = require('views/upload');

  module.exports = Layout = (function(_super) {

    __extends(Layout, _super);

    function Layout() {
      return Layout.__super__.constructor.apply(this, arguments);
    }

    Layout.prototype.events = {
      'click a[href="#upload"]': 'showUpload'
    };

    Layout.prototype.initialize = function() {
      Layout.__super__.initialize.apply(this, arguments);
      console.log("Initializing the Layout");
      return this.header = new HeaderView;
    };

    Layout.prototype.showUpload = function(e) {
      e.preventDefault();
      console.log("Showing Upload");
      return this.upload = new UploadView;
    };

    return Layout;

  })(Chaplin.Layout);
  
}});

window.require.define({"views/login": function(exports, require, module) {
  var LoginView, ModalView, template,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  ModalView = require('views/base/modal');

  template = require('views/templates/login');

  module.exports = LoginView = (function(_super) {

    __extends(LoginView, _super);

    function LoginView() {
      this.modalSubmit = __bind(this.modalSubmit, this);
      return LoginView.__super__.constructor.apply(this, arguments);
    }

    LoginView.prototype.template = template;

    LoginView.prototype.container = 'body';

    LoginView.prototype.autoRender = true;

    LoginView.prototype.id = "view-login-modal";

    LoginView.prototype.events = {
      'click #modal-submit': 'modalSubmit',
      'click a[href="#create-account"]': 'showCreateAccountView'
    };

    LoginView.prototype.initialize = function(data) {
      LoginView.__super__.initialize.apply(this, arguments);
      return console.log("Initializing the Login View");
    };

    LoginView.prototype.modalSubmit = function(e) {
      e.preventDefault();
      console.log("hit");
      return window.location.href = '/dashboard';
    };

    LoginView.prototype.showCreateAccountView = function(e) {
      e.preventDefault();
      return window.location.href = '/join';
    };

    return LoginView;

  })(ModalView);
  
}});

window.require.define({"views/photo_collection_item_view": function(exports, require, module) {
  var PhotoCollectionItemView, View, template,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  View = require('views/base/view');

  template = require('views/templates/photo_collection_item');

  module.exports = PhotoCollectionItemView = (function(_super) {

    __extends(PhotoCollectionItemView, _super);

    function PhotoCollectionItemView() {
      return PhotoCollectionItemView.__super__.constructor.apply(this, arguments);
    }

    PhotoCollectionItemView.prototype.template = template;

    PhotoCollectionItemView.prototype.autoRender = false;

    PhotoCollectionItemView.prototype.tagName = 'li';

    PhotoCollectionItemView.prototype.className = 'photo-wrapper';

    PhotoCollectionItemView.prototype.initialize = function() {
      PhotoCollectionItemView.__super__.initialize.apply(this, arguments);
      return console.log('PhotoCollectionItemView#initialize');
    };

    PhotoCollectionItemView.prototype.render = function() {
      PhotoCollectionItemView.__super__.render.apply(this, arguments);
      return console.log('Photo Rendered', this);
    };

    return PhotoCollectionItemView;

  })(View);
  
}});

window.require.define({"views/photo_collection_view": function(exports, require, module) {
  var CollectionView, PhotoCollectionView, itemView, template,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  CollectionView = require('views/base/collection_view');

  itemView = require('views/photo_collection_item_view');

  template = require('views/templates/photo_collection');

  module.exports = PhotoCollectionView = (function(_super) {

    __extends(PhotoCollectionView, _super);

    function PhotoCollectionView() {
      return PhotoCollectionView.__super__.constructor.apply(this, arguments);
    }

    PhotoCollectionView.prototype.template = template;

    PhotoCollectionView.prototype.container = '#master-container';

    PhotoCollectionView.prototype.autoRender = true;

    PhotoCollectionView.prototype.itemView = itemView;

    PhotoCollectionView.prototype.listSelector = '#photos-list';

    PhotoCollectionView.prototype.id = "photo-collection-wrapper";

    PhotoCollectionView.prototype.initialize = function(data) {
      PhotoCollectionView.__super__.initialize.apply(this, arguments);
      return console.log("Initializing the PhotoCollectionView");
      /*
          rendered = no
          @modelBind 'change', =>
            @render() unless rendered
            rendered = yes
      */

    };

    PhotoCollectionView.prototype.afterRender = function() {
      PhotoCollectionView.__super__.afterRender.apply(this, arguments);
      return console.log("How many times am I rendering?");
    };

    PhotoCollectionView.prototype.renderAllItems = function() {
      var $photoList, isotopeConfig;
      PhotoCollectionView.__super__.renderAllItems.apply(this, arguments);
      console.log('collection rendered');
      $photoList = $("#photos-list");
      isotopeConfig = {
        itemSelector: ".photo-wrapper",
        layoutMode: "cellsByRow",
        cellsByRow: {
          columnWidth: 260,
          rowHeight: 400
        }
      };
      return $photoList.imagesLoaded(function() {
        console.log("Photos loaded", this);
        $photoList.isotope(isotopeConfig);
        return $photoList.isotope({
          getSortData: {
            stars: function($elem) {
              return $elem.find("[data-stars]").text();
            }
          }
        });
      });
      /*
          navButtons = {
            stars: {
              els: $('#navigation .btn'),
              pressed: [],
              pressedCount: 0,
      
              1: {}
            }
          }
      
          filters = {};
          filters.stars = (values) ->
            filter = '';
      
            _.each values, (value, key) ->
              if(key > 0)
                filter = filter + ', '
      
              filter = filter + '[data-stars=' + value + ']'
      
            $photoList.isotope({ filter: filter });
      
          #Top navigation - Clicking on stars
          $('#filter-star-container').on 'click', '.btn', (e) ->
            e.preventDefault();
      
            id    = $(@).attr('id')
            value = id.substr(id.length - 1)
      
            #If button has not been pressed
            if _.indexOf(navButtons.stars.pressed, value) == -1
              #navButtons.stars.els.removeClass('active');
              $(@).addClass('active');
              navButtons.stars.pressed.push(value);
              navButtons.stars.pressedCount += 1;
              filters.stars(navButtons.stars.pressed);
            
            #If button has been pressed
            else
              $(@).removeClass('active');
              navButtons.stars.pressedCount -= 1;
              navButtons.stars.pressed.splice(navButtons.stars.pressed.indexOf(value),1); #Remove value from pressed array
      
              if navButtons.stars.pressedCount == 0
                $photoList.isotope({ filter: isotopeConfig.itemSelector });
                navButtons.stars.pressed = null;
      
              else
                filters.stars(navButtons.stars.pressed);
      
          #Photo - Colors
          setPhotoColor = ($photo, color) ->
            $photoWrapper = $photo.parents('.photo-wrapper');
      
            if $photo.hasClass('active')
              $photo.removeClass('active');
              $photoWrapper.attr('data-color-' + color, 0);
            
            else
              $photo.addClass('active');
              $photoWrapper.attr('data-color-' + color, 1);
      
          $('.photo-colors').on 'click', 'a', (e) ->
            e.preventDefault()
      
            if $(@).hasClass('photo-color-red')
              setPhotoColor($(@), 'red')
      
            if $(@).hasClass('photo-color-orange')
              setPhotoColor($(@), 'orange')
      
            if $(@).hasClass('photo-color-yellow')
              setPhotoColor($(@), 'yellow')
      
            if $(@).hasClass('photo-color-green')
              setPhotoColor($(@), 'green');
      
            if $(@).hasClass('photo-color-blue')
              setPhotoColor($(@), 'blue')
      
            if $(@).hasClass('photo-color-purple')
              setPhotoColor($(@), 'purple')
      
          #Photo - Stars dropup
          $('.num-stars-container').on 'click', 'a', (e) ->
            e.preventDefault();
      
            $photoWrapper = $(@).parents('.photo-wrapper')
            value         = $(@).html();
      
            #Updates the star count in the dropup display
            $photoWrapper.find('.num-stars').html(value);
      
            #Update the star count on the photo's html data attribute
            $photoWrapper.attr('data-stars', value);
      
            #Check to see if isotope filter needs to be run again to reflect photo star value change
            if navButtons.stars.pressed != null
              filters.stars(navButtons.stars.pressed);
      
          #Sidebar - star sorting
          $("#sort-stars-highest").on 'click', ->
            $photoList.isotope({ sortBy: 'stars', sortAscending : false });
      
          $("#sort-stars-lowest").on 'click', ->
            $photoList.isotope({ sortBy: 'stars', sortAscending : true });
      */

    };

    return PhotoCollectionView;

  })(CollectionView);
  
}});

window.require.define({"views/templates/header": function(exports, require, module) {
  module.exports = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
    helpers = helpers || Handlebars.helpers;
    var foundHelper, self=this;


    return "<div class=\"container\">\n	<a class=\"brand\" href=\"#\">Nakama</a>\n	<ul class=\"nav\">\n		<li><a href=\"#upload\">Upload</a></li>\n		<li><a href=\"#\">Logout</a></li>\n	</ul>\n</div>";});
}});

window.require.define({"views/templates/join": function(exports, require, module) {
  module.exports = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
    helpers = helpers || Handlebars.helpers;
    var foundHelper, self=this;


    return "<div class=\"modal-container\">\n	<h1>Create Account</h1>\n	<div><input id=\"create-account-name\" type=\"text\" placeholder=\"Name\" /></div>\n	<div><input id=\"create-account-email\" type=\"text\" placeholder=\"Email\" /></div>\n	<div><input id=\"create-account-username\" type=\"text\" placeholder=\"Username\" /></div>\n	<div><input id=\"create-account-password\" type=\"password\" placeholder=\"Password\" /></div>\n	<div>\n		<button id=\"modal-submit\" class=\"btn btn-primary\">Submit</button>\n	</div>\n</div>";});
}});

window.require.define({"views/templates/login": function(exports, require, module) {
  module.exports = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
    helpers = helpers || Handlebars.helpers;
    var foundHelper, self=this;


    return "<div class=\"modal-container\">\n	<h1>Login</h1>\n	<div><input type=\"text\" placeholder=\"Username\" /></div>\n	<div><input type=\"password\" placeholder=\"Password\" /></div>\n	<div>\n		<button id=\"modal-submit\" class=\"btn btn-primary\">Login</button>\n		<a class=\"btn\" href=\"#create-account\">Create Account</a>\n	</div>\n</div>";});
}});

window.require.define({"views/templates/photo_collection": function(exports, require, module) {
  module.exports = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
    helpers = helpers || Handlebars.helpers;
    var foundHelper, self=this;


    return "<ul id=\"photos-list\"></ul>";});
}});

window.require.define({"views/templates/photo_collection_item": function(exports, require, module) {
  module.exports = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
    helpers = helpers || Handlebars.helpers;
    var buffer = "", stack1, foundHelper, self=this, functionType="function", helperMissing=helpers.helperMissing, undef=void 0, escapeExpression=this.escapeExpression;


    buffer += "<div class=\"photo-container\">\n	<img src=\"";
    foundHelper = helpers.path;
    stack1 = foundHelper || depth0.path;
    if(typeof stack1 === functionType) { stack1 = stack1.call(depth0, { hash: {} }); }
    else if(stack1=== undef) { stack1 = helperMissing.call(depth0, "path", { hash: {} }); }
    buffer += escapeExpression(stack1) + "\" />\n</div>";
    return buffer;});
}});

window.require.define({"views/templates/upload": function(exports, require, module) {
  module.exports = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
    helpers = helpers || Handlebars.helpers;
    var foundHelper, self=this;


    return "<div class=\"modal-container\">\n	<div>Upload stuff</div>\n</div>";});
}});

window.require.define({"views/upload": function(exports, require, module) {
  var ModalView, UploadView, template,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  ModalView = require('views/base/modal');

  template = require('views/templates/upload');

  module.exports = UploadView = (function(_super) {

    __extends(UploadView, _super);

    function UploadView() {
      return UploadView.__super__.constructor.apply(this, arguments);
    }

    UploadView.prototype.autoRender = true;

    UploadView.prototype.container = '#master-upload';

    UploadView.prototype.id = 'view-upload';

    UploadView.prototype.template = template;

    UploadView.prototype.initialize = function() {
      UploadView.__super__.initialize.apply(this, arguments);
      return console.log("Initializing the Upload View");
    };

    return UploadView;

  })(ModalView);
  
}});

