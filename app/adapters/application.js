import DS from "ember-data";
import DataAdapterMixin from 'ember-simple-auth/mixins/data-adapter-mixin';

var ApplicationAdapter = DS.RESTAdapter.extend(DataAdapterMixin, {
    host: 'http://localhost:3000',
    authorizer: 'authorizer:devise'
});

export default ApplicationAdapter;
