import Ember from 'ember'
import AbstractRoutesPublicRouteRoute from './abstract-routes/public-route'
import UnauthenticatedRouteMixin from 'ember-simple-auth/mixins/unauthenticated-route-mixin'

LoginRoute = AbstractRoutesPublicRouteRoute.extend(UnauthenticatedRouteMixin,
)

export default LoginRoute
