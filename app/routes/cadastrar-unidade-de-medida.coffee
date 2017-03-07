import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from './abstract-routes/private-route'

CadastrarUnidadeDeMedidaRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->
    return @get("store").createRecord("unidade-medida")

  actions:

    willTransition: ->
      model = @controllerFor("cadastrar-unidade-de-medida").get("model")

      if model.get("isNew")
        @get("store").unloadRecord(model)

    actRedirecionar: ->
      @transitionTo("unidades-de-medida")

)

export default CadastrarUnidadeDeMedidaRoute
