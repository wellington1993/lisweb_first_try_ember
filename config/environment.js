/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'lisweb-cli',
    environment: environment,
    rootURL: '/',
    contentSecurityPolicy: {
        'default-src': ["'none'"],
        'script-src':  ["'self'", "'unsafe-eval'", "*"],
        'font-src':    ["'self'"],
        'connect-src': ["'self'", "*"],
        'img-src':     ["'self'"],
        'style-src':   ["'self'", "'unsafe-inline'"],
        'media-src':   ["'self'"]
    },
    locationType: 'auto',
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    }
  };

  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    // ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    // ENV.APP.LOG_VIEW_LOOKUPS = true;
    ENV.host = "http://localhost:3000";
    ENV.locationType = "hash"
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.baseURL = '/';
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';

    ENV.host = "http://minha-api-de-testes";
  }

  if (environment === 'production') {
    ENV.host = "http://apilisweb.acras.com.br";
  }

  ENV['ember-simple-auth'] = {
    authenticationRoute: 'login',
    routeAfterAuthentication: 'index',
    routeIfAlreadyAuthenticated: 'index'
  }

  return ENV;
};
