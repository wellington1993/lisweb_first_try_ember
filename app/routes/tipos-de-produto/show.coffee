import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

TiposDeProdutoShowRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->

    self = @

    tipoProduto =
      @get("store").findRecord("tipo-produto", params["tipo_produto_id"], reload: true).then(

        (data) ->
          return data

        (err) ->
          self.transitionTo("tipos-de-produto")

       )

     return tipoProduto

  actions:

    #Se os atributos foram alterados e não salvos ao sair da rota as alterações
    #devem ser desfeitas.
    willTransition: ->
      @controllerFor("tipos-de-produto.show").get("model").rollbackAttributes()

    actRedirecionar: ->
      @transitionTo("tipos-de-produto")

)

export default TiposDeProdutoShowRoute
