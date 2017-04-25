import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

MarcasNewRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->
    return @get("store").createRecord("marca")

  actions:

    willTransition: ->
      model = @controllerFor("marcas/new").get("model")

      if model.get("isNew")
        @get("store").unloadRecord(model)

    actRedirecionar: ->
      @transitionTo("marcas/index")

)

export default MarcasNewRoute
