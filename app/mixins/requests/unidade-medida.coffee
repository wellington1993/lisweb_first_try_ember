import Ember from 'ember'

RequestsUnidadeMedidaMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  cadastrarUnidadeMedida: (context, options, callback = ->) ->

    if options.hasOwnProperty("unidadeMedida")
      return options["unidadeMedida"].save()
    else
      return @get("store").createRecord("unidade-medida", options["attrs"]).save()

  atualizarUnidadeMedida: (context, options, callback = ->) ->

    if options.hasOwnProperty("unidadeMedida")
      return options["unidadeMedida"].save()


)

export default RequestsUnidadeMedidaMixin
