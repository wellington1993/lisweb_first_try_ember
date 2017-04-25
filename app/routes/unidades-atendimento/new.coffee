import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

UnidadesAtendimentoNewRoute = AbstractRoutesPrivateRouteRoute.extend(
  model: (params, transition) ->
    return @get("store").createRecord("unidade-atendimento")

  actions:
    willTransition: ->
      model = @controllerFor("unidades-atendimento/new").get("model")
      if model.get("isNew")
        @get("store").unloadRecord(model)

    actRedirecionar: ->
      @transitionTo("unidades-atendimento/index")
)

export default UnidadesAtendimentoNewRoute
