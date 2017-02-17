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
    return @sessionStillValid(data)

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

  sessionStillValid: (data = null) ->

    self = @

    if data != null
      authenticatedData = data
    else
      authenticatedData = @get("data")["authenticated"]

    return new Ember.RSVP.Promise(

      (resolve, reject) ->

        if !(authenticatedData.hasOwnProperty("email") && authenticatedData.hasOwnProperty("token"))
          return reject()

        params =
          email: authenticatedData.email
          token: authenticatedData.token

        self.get("request").makeRequest(self, self.userTokenStillValid, params,

          (success, data, httpCode) ->

            if success
              return resolve(data)

            return reject()

        )

    )

)

export default ApplicationAuthenticator
