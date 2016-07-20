import Ember from 'ember';
import DS from "ember-data";

var ApplicationAdapter = DS.RESTAdapter.extend({
    host: 'http://localhost:3000'
});

export default ApplicationAdapter;
