import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from './abstract-routes/private-route'

TiposDePessoaRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: ->
    return @get("store").findAll("tipo-pessoa")

)

export default TiposDePessoaRoute
