import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

UnidadesDeMedidaNewRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->
    return @get("store").createRecord("unidade-medida")

  actions:

    willTransition: ->
      model = @controllerFor("unidades-de-medida/new").get("model")

      if model.get("isNew")
        @get("store").unloadRecord(model)

    actRedirecionar: ->
      @transitionTo("unidades-de-medida/index")

)

export default UnidadesDeMedidaNewRoute
