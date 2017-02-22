import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from './abstract-routes/private-route'

UnidadesDeMedidaRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: ->
    @get("store").findAll("unidade-medida")

)

export default UnidadesDeMedidaRoute
