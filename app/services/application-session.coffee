import Ember from 'ember'

ApplicationSessionService = Ember.Service.extend(

  session: Ember.inject.service()

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

)

export default ApplicationSessionService
