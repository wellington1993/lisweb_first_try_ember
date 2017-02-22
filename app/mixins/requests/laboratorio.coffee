import Ember from 'ember'

RequestsLaboratorioMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  obterLaboratorioAtual: ->
    return @get("store").queryRecord("laboratorio", internal_action: "laboratorio_atual")

  escolherLaboratorio: (context, params, callback) ->

    laboratorioId = params["laboratorioId"]

    ajaxParams =
      url: "/users/me/escolher_laboratorio/#{laboratorioId}"
      type: "POST"

    context.get("store").doAjax(context, callback, ajaxParams)

)

export default RequestsLaboratorioMixin
