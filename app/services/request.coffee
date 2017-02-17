#Este serviço foi criado com o intuito de centralizar todas as requisições,
#principalmente chamadas não ember-data.
#Caso existam tratamentos que sejam válidas para todas as requests pode ser
#implementado no método makeRequest.

import Ember from 'ember'
import ENV from '../config/environment'

RequestService = Ember.Service.extend(

  store: Ember.inject.service()

  #Método para realizar qualquer requisição na aplicação.
  makeRequest: (context, method, params, callback, options = {}) ->

      if ENV.environment == "development"
        console.log("\nRequisição será chamada...")
        console.log("Método: " + method.name)
        console.log("Parâmetros: " + JSON.stringify(params) + "\n")

      return method(@, params, callback)



)

export default RequestService
