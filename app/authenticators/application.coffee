import Devise from 'ember-simple-auth/authenticators/devise'
import RequestsAuthenticationMixin from '../mixins/requests/authentication'

ApplicationAuthenticator = Devise.extend(RequestsAuthenticationMixin,

  store: Ember.inject.service()
  request: Ember.inject.service()

  #Override.
  init: ->

    #Assegura comportamento padrão da classe.
    @_super()

    #Concatena o endereço do servidor + o endpoint padrão do authenticator.
    @set("serverTokenEndpoint", @get("store").adapterFor("application").get("host") + @get("serverTokenEndpoint"))

  #Override
  restore: (data) ->

    self = @

    #Faz a verificação no servidor se as credenciais existentes ainda são válidas.
    return new Ember.RSVP.Promise(

      (resolve, reject) ->

        if !data.token
          return reject()

        params =
          email: data.email
          token: data.token

        self.get("request").makeRequest(self, self.userTokenStillValid, params,

          (success, data, httpCode) ->

            if success
              return resolve(data)

            return reject()

        )

    )

  #Override
  invalidate: (data) ->

    self = @

    #Faz a requisição para destruição do token atual.
    return new Ember.RSVP.Promise(

      (resolve, reject) ->

        self.get("request").makeRequest(self, self.logout, {},

          (success, data, httpCode) ->

            if success
              return resolve()

            return reject()

        )

    )

)

export default ApplicationAuthenticator
