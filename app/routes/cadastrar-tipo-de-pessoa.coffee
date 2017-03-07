import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from './abstract-routes/private-route'

CadastrarTipoDePessoaRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->
    return @get("store").createRecord("tipo-pessoa")

  actions:

    willTransition: ->
      model = @controllerFor("cadastrar-tipo-de-pessoa").get("model")

      if model.get("isNew")
        @get("store").unloadRecord(model)

    actRedirecionar: ->
      @transitionTo("tipos-de-pessoa")

)

export default CadastrarTipoDePessoaRoute
