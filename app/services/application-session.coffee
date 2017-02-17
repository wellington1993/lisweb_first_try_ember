#Este serviço deve ser utilizado para realizar operações de autenticações na
#aplicação. Os serviços do ember-simple-auth estão contidos nos métodos deste
#serviço e devem ser acessados somente pelos métodos wrap deste serviço e não
#acessar o ember-simple-auth diretamente.

import Ember from 'ember'

ApplicationSessionService = Ember.Service.extend(

  session: Ember.inject.service()

  isAuthenticated: Ember.computed("session.isAuthenticated", ->
    return @get("session").get("isAuthenticated")
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

)

export default ApplicationSessionService
