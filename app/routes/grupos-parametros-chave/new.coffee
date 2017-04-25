import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

GruposParametrosChaveNewRoute = AbstractRoutesPrivateRouteRoute.extend(
  model: (params, transition) ->
    return @get("store").createRecord("grupo-parametro-chave")

  actions:
    willTransition: ->
      model = @controllerFor("grupos-parametros-chave/new").get("model")
      if model.get("isNew")
        @get("store").unloadRecord(model)

    actRedirecionar: ->
      @transitionTo("grupos-parametros-chave/index")
)

export default GruposParametrosChaveNewRoute
