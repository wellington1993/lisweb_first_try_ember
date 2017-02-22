import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from './abstract-routes/private-route'

MarcasRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: ->
    return @get("store").findAll("marca")

)

export default MarcasRoute
