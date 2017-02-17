import Ember from 'ember'

RequestsAuthenticationMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  #Método para destruir o token existente no servidor.
  logout: (context, params, callback) ->

    ajaxParams =
      url: "/users/sign_out"
      type: "DELETE"

    context.get("store").doAjax(context, callback, ajaxParams)

  #Método para verificar se o token existente ainda é válido.
  userTokenStillValid: (context, params, callback) ->

    #Os headers são setados manualmente neste ponto pois o ember-simple-auth
    #considera que o usuário ainda não está autenticado (pois está no método restore).
    ajaxParams =
      headers: "Authorization" : "Token token=#{params["token"]}, email=#{params["email"]}"
      url: "/users/me"
      type: "GET"

    context.get("store").doAjax(context, callback, ajaxParams)


)

export default RequestsAuthenticationMixin
