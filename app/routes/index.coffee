import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from './abstract-routes/private-route'

IndexRoute = AbstractRoutesPrivateRouteRoute.extend(

  actions:
    actRedirecionarDashboard: (rota) ->
      @transitionTo(rota)

)

export default IndexRoute
