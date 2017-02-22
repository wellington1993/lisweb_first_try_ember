import Ember from 'ember'

RequestsTipoPessoaMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  cadastrarTipoPessoa: (context, options, callback = ->) ->
    return @get("store").createRecord("tipo-pessoa", options["attrs"]).save()

)

export default RequestsTipoPessoaMixin
