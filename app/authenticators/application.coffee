import Devise from 'ember-simple-auth/authenticators/devise'

ApplicationAuthenticator = Devise.extend(

  store: Ember.inject.service()
  applicationSession: Ember.inject.service()

  #Override.
  init: ->

    #Assegura comportamento padrão da classe.
    @_super()

    #Concatena o endereço do servidor + o endpoint padrão do authenticator.
    @set("serverTokenEndpoint", @get("store").adapterFor("application").get("host") + @get("serverTokenEndpoint"))

  restore: (data) ->

    applicationSession = @get("applicationSession")

    return new Ember.RSVP.Promise(

      (resolve, reject) ->

        token = data.token

        if !token
          return reject()

        params =
          token: data.token
          email: data.email

        applicationSession.sessionStillValid(params,

          (success, data, httpCode) ->

            if success
              return resolve()

        )



    )

)

export default ApplicationAuthenticator
