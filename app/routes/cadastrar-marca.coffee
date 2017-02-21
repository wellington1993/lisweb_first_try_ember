import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from './abstract-routes/private-route'

CadastrarMarcaRoute = AbstractRoutesPrivateRouteRoute.extend(

  actions:

    actRedirecionarAposCadastro: ->
      @transitionTo("marcas")

)

export default CadastrarMarcaRoute
