import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from './abstract-routes/private-route'

MarcasRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: ->
    @get("store").findAll("marca")

)

export default MarcasRoute
