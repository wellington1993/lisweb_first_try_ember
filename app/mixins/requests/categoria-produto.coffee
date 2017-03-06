import Ember from 'ember'

RequestsCategoriaProdutoMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  cadastrarCategoriaProduto: (context, options, callback = ->) ->

    if options.hasOwnProperty("categoriaProduto")
      return options["categoriaProduto"].save()
    else
      return @get("store").createRecord("categoria-produto", options["attrs"]).save()

  atualizarCategoriaProduto: (context, options, callback = ->) ->

    if options.hasOwnProperty("categoriaProduto")
      return options["categoriaProduto"].save()


)

export default RequestsCategoriaProdutoMixin
