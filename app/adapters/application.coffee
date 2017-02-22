import DS from 'ember-data'
import ENV from '../config/environment'
import DataAdapterMixin from 'ember-simple-auth/mixins/data-adapter-mixin'

ApplicationAdapter = DS.RESTAdapter.extend(DataAdapterMixin,

  #O host do adapter é definido no arquivo /config/environment.js.
  host: ENV.host

  #Define o authorizer da aplicação para, quando autenticado, todas as requests
  #do Ember-Data estejam autorizadas.
  authorizer: 'authorizer:application'

  handleResponse: (status, headers, payload, requestData) ->

    if status == 403
      window.location.href = "/nao-autorizado"
    else
      return @_super(status, headers, payload, requestData)

  pathForType: (modelName) ->
    return modelName.pluralize().underscore()

)

export default ApplicationAdapter
