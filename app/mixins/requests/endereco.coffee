import Ember from 'ember'

RequestsEnderecoMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  obterEnderecoPorCep: (context, params, callback) ->

    ajaxParams =
      url: "https://viacep.com.br/ws/" + params["cep"] + "/json"
      method: 'GET'
      timeout: 8000
      overrideHeaders: true

    context.get("store").doAjax(context, callback, ajaxParams)

)

export default RequestsEnderecoMixin
