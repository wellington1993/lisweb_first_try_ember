import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from './abstract-routes/private-route'

CadastrarCategoriaDeProdutoRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->
    return @get("store").createRecord("categoria-produto")

  actions:

    willTransition: ->
      model = @controllerFor("cadastrar-categoria-de-produto").get("model")

      if model.get("isNew")
        @get("store").unloadRecord(model)

    actRedirecionar: ->
      @transitionTo("categorias-de-produto")


)

export default CadastrarCategoriaDeProdutoRoute
