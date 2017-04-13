import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from './abstract-routes/private-route'

CadastrarChaveNfseRoute = AbstractRoutesPrivateRouteRoute.extend(
  model: (params, transition) ->
    return @get("store").createRecord("chave-nfse")

  actions:
    willTransition: ->
      model = @controllerFor("cadastrar-chave-nfse").get("model")
      if model.get("isNew")
        @get("store").unloadRecord(model)

    actRedirecionar: ->
      @transitionTo("chaves-nfse")
)

export default CadastrarChaveNfseRoute
