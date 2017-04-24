import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

CategoriasDeProdutoNewRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->
    return @get("store").createRecord("categoria-produto")

  actions:

    willTransition: ->
      model = @controllerFor("categorias-de-produto/new").get("model")

      if model.get("isNew")
        @get("store").unloadRecord(model)

    actRedirecionar: ->
      @transitionTo("categorias-de-produto/index")


)

export default CategoriasDeProdutoNewRoute
