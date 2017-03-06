import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

UnidadesDeMedidaShowRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->

    self = @

    unidadeMedida =
      @get("store").findRecord("unidade-medida", params["unidade_medida_id"], reload: true).then(

        (data) ->
          return data

        (err) ->
          self.transitionTo("unidades-de-medida")

       )

     return unidadeMedida

  actions:

    #Se os atributos foram alterados e não salvos ao sair da rota as alterações
    #devem ser desfeitas.
    willTransition: ->
      @controllerFor("unidades-de-medida.show").get("model").rollbackAttributes()

    actRedirecionar: ->
      @transitionTo("unidades-de-medida")


)

export default UnidadesDeMedidaShowRoute
