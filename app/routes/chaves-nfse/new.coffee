import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

ChavesNfseNewRoute = AbstractRoutesPrivateRouteRoute.extend(
  model: (params, transition) ->
    return @get("store").createRecord("chave-nfse")

  actions:
    willTransition: ->
      model = @controllerFor("chaves-nfse/new").get("model")
      if model.get("isNew")
        @get("store").unloadRecord(model)

    actRedirecionar: ->
      @transitionTo("chaves-nfse/index")
)

export default ChavesNfseNewRoute
