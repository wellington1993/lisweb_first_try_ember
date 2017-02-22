import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from './abstract-routes/private-route'

CategoriasDeProdutoRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: ->
    return @get("store").findAll("categoria-produto")

)

export default CategoriasDeProdutoRoute
