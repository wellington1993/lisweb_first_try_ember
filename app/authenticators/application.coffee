import Devise from 'ember-simple-auth/authenticators/devise'

ApplicationAuthenticator = Devise.extend(

  store: Ember.inject.service()

  #Override.
  init: ->

    #Assegura comportamento padrão da classe.
    @_super()

    #Concatena o endereço do servidor + o endpoint padrão do authenticator.
    @set("serverTokenEndpoint", @get("store").adapterFor("application").get("host") + @get("serverTokenEndpoint"))

)

export default ApplicationAuthenticator
