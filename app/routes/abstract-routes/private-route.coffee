import Ember from 'ember'
import AbstractRoutesGenericRouteRoute from './generic-route'
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'

AbstractRoutesPrivateRouteRoute = AbstractRoutesGenericRouteRoute.extend(AuthenticatedRouteMixin,

)

export default AbstractRoutesPrivateRouteRoute
