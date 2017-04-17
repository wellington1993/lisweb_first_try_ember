import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from './abstract-routes/private-route'

CadastrarUnidadeAtendimentoRoute = AbstractRoutesPrivateRouteRoute.extend(
  model: (params, transition) ->
    return @get("store").createRecord("unidade-atendimento")

  actions:
    willTransition: ->
      model = @controllerFor("cadastrar-unidade-atendimento").get("model")
      if model.get("isNew")
        @get("store").unloadRecord(model)

    actRedirecionar: ->
      @transitionTo("unidades-atendimento")
)

export default CadastrarUnidadeAtendimentoRoute
