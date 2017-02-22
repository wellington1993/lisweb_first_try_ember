import Ember from 'ember'

RequestsLaboratorioMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  obterLaboratorioAtual: ->
    return @get("store").queryRecord("laboratorio", internal_action: "laboratorio_atual")

  escolherLaboratorio: (params) ->
    

)

export default RequestsLaboratorioMixin
