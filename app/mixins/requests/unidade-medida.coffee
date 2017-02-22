import Ember from 'ember'

RequestsUnidadeMedidaMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  cadastrarUnidadeMedida: (context, options, callback = ->) ->
    return @get("store").createRecord("unidade-medida", options["attrs"]).save()

)

export default RequestsUnidadeMedidaMixin
