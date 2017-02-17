import Ember from 'ember'

AbstractRoutesGenericRouteRoute = Ember.Route.extend(

  applicationSession: Ember.inject.service()

)

export default AbstractRoutesGenericRouteRoute
