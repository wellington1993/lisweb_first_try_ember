import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('marcas');
  this.route('login');
  this.route('dashboard');
});

export default Router;
