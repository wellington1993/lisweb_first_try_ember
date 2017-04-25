import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

TiposDePessoaNewRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->
    return @get("store").createRecord("tipo-pessoa")

  actions:

    willTransition: ->
      model = @controllerFor("tipos-de-pessoa/new").get("model")

      if model.get("isNew")
        @get("store").unloadRecord(model)

    actRedirecionar: ->
      @transitionTo("tipos-de-pessoa/index")

)

export default TiposDePessoaNewRoute
