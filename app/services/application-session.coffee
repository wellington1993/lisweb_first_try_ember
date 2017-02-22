#Este serviço deve ser utilizado para realizar operações de autenticações na
#aplicação. Os serviços do ember-simple-auth estão contidos nos métodos deste
#serviço e devem ser acessados somente pelos métodos wrap deste serviço e não
#acessar o ember-simple-auth diretamente.

import Ember from 'ember'
import RequestsLaboratorioMixin from '../mixins/requests/laboratorio'

ApplicationSessionService = Ember.Service.extend(RequestsLaboratorioMixin,

  session: Ember.inject.service()
  request: Ember.inject.service()

  isAuthenticated: Ember.computed("session.isAuthenticated", ->
    return @get("session").get("isAuthenticated")
  )

  laboratorioAtual: Ember.computed("session.store.laboratorioAtual", ->
    return @get("session.store.laboratorioAtual")
  )

  #Método para realizar login na aplicação.
  login: (params, callback) ->

    @get("session").authenticate('authenticator:application', params["email"], params["password"]).then(
      (data) ->
        return callback(true, data)
      (errors) ->
        return callback(false, errors)
    )


  #Método para destruir a sessão existente (wrap do ember-simple-auth)
  logout: (params, callback) ->

    self = @

    return (

      self.get("session").invalidate().then(

        (data) ->
          callback(true, data)

        (erros) ->
          return callback(false, errors)
      )

    )

  #Verifica se a sessão do usuário ainda é válida.
  sessionStillValid: (params, callback) ->

    @get("session").sessionStillValid().then(
      (data) ->
        return callback(true, data)
      (errors) ->
        return callback(false, errors)
    )

  escolherLaboratorioUsuario: (laboratorio, callback) ->

    self = @

    @get("request").makeRequest(@, @escolherLaboratorio, laboratorioId: laboratorio.get("id"),

      (sucesso, dados, httpCode) ->

        if sucesso
          self.set("session.store.laboratorioAtual", laboratorio)

        return callback(sucesso, dados, httpCode)

    )

  obterLaboratorioAtualUsuario: ->

    self = @

    return @obterLaboratorioAtual().then(
      (laboratorioAtual) ->
        self.set("session.store.laboratorioAtual", laboratorioAtual)
    )

)

export default ApplicationSessionService
