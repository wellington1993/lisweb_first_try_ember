import DS from 'ember-data'
import ENV from '../config/environment'
import DataAdapterMixin from 'ember-simple-auth/mixins/data-adapter-mixin'

ApplicationAdapter = DS.RESTAdapter.extend(DataAdapterMixin,

  #O host do adapter é definido no arquivo /config/environment.js.
  host: ENV.host

  #Define o authorizer da aplicação para, quando autenticado, todas as requests
  #do Ember-Data estejam autorizadas.
  authorizer: 'authorizer:application'

)

export default ApplicationAdapter
