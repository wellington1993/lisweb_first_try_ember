import Ember from 'ember'

RequestsPessoaMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  cadastrarPessoa: (context, options, callback = ->) ->
    return @get("store").createRecord("pessoa", options["attrs"]).save()

)

export default RequestsPessoaMixin
