import Ember from 'ember';

export default Ember.Controller.extend({
  session: Ember.inject.service('session'),
  actions: {
    setLab: function(i) {
      alert(i);
      return false;
    }
  }
});
