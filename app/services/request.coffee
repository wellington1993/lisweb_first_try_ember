import Ember from 'ember'
import ENV from '../config/environment'
import DataAdapterMixin from 'ember-simple-auth/mixins/data-adapter-mixin'

RequestService = Ember.Service.extend(DataAdapterMixin,

  store: Ember.inject.service()

  #Método para realizar qualquer requisição na aplicação.
  makeRequest: (context, method, params, callback, options = {}) ->

      if ENV.environment == "development"
        console.log("\nRequisiçaõ será chamada...")
        console.log("Método: " + method.name)
        console.log("Parâmetros: " + JSON.stringify(params) + "\n")

      #TODO: em códigos 401, verificar se o token é válido e realizar tratamentos.

      method(@, params,

        (success, data, httpCode) ->

          if !success && httpCode == 401
            console.log("Erro de autorização na request... Verificar se o token ainda é válido ou verificar se o usuário logado possui acesso para o método.")

          return callback(success, data, httpCode)

      )



)

export default RequestService
