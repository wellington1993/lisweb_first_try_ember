import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

CategoriasDeProdutoShowRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->

    self = @

    categoriaProduto =
      @get("store").findRecord("categoria-produto", params["categoria_produto_id"], reload: true).then(

        (data) ->
          return data

        (err) ->
          self.transitionTo("categorias-de-produto")

       )

     return categoriaProduto

  actions:

    #Se os atributos foram alterados e não salvos ao sair da rota as alterações
    #devem ser desfeitas.
    willTransition: ->
      @controllerFor("categorias-de-produto.show").get("model").rollbackAttributes()

    actRedirecionar: ->
      @transitionTo("categorias-de-produto")

)

export default CategoriasDeProdutoShowRoute
