import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from './abstract-routes/private-route'

CadastrarUnidadeDeMedidaRoute = AbstractRoutesPrivateRouteRoute.extend(

  actions:

    actRedirecionarAposCadastro: ->
      @transitionTo("unidades-de-medida")

)

export default CadastrarUnidadeDeMedidaRoute
