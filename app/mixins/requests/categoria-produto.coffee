import Ember from 'ember'

RequestsCategoriaProdutoMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  cadastrarCategoriaProduto: (context, options, callback = ->) ->
    return @get("store").createRecord("categoria-produto", options["attrs"]).save()

)

export default RequestsCategoriaProdutoMixin
