import Ember from 'ember'

RequestsTipoProdutoMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  cadastrarTipoProduto: (context, options, callback = ->) ->
    return options["tipoProduto"].save()

)

export default RequestsTipoProdutoMixin
