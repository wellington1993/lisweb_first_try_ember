import Devise from 'ember-simple-auth/authenticators/devise'
import RequestsAuthenticationMixin from '../mixins/requests/authentication'

#Autenticador do addon ember-simple-auth para manter sessões na aplicação.
ApplicationAuthenticator = Devise.extend(RequestsAuthenticationMixin,

  store: Ember.inject.service()
  request: Ember.inject.service()

  #Override.
  init: ->

    #Assegura comportamento padrão da classe.
    @_super()

    #Concatena o endereço do servidor + o endpoint padrão do authenticator para
    #utilizar como URL padrão de login.
    @set("serverTokenEndpoint", @get("store").adapterFor("application").get("host") + @get("serverTokenEndpoint"))

  #Override
  restore: (data) ->

    #Faz a verificação de token ainda válido.
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

  #Método para verificar se o token armazenado na aplicação ainda é válido no
  #servidor.
  sessionStillValid: (data = null) ->

    self = @

    #Tenta obter os dados salvos na sessão.
    if data != null
      authenticatedData = data
    else
      authenticatedData = @get("data")["authenticated"]

    return new Ember.RSVP.Promise(

      (resolve, reject) ->

        #Se não há e-mail e token armazenado na aplicação rejeita a promise.
        if !(authenticatedData.hasOwnProperty("email") && authenticatedData.hasOwnProperty("token"))
          return reject()

        #Prepara os dados e faz requisição ao servidor com email e token
        #que ainda estão na aplicação.
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
