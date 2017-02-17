import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from './abstract-routes/private-route'

LaboratoriosRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: ->
    @get("store").findAll("laboratorio")

)

export default LaboratoriosRoute
