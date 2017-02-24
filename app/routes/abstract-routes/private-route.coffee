import Ember from 'ember'
import AbstractRoutesGenericRouteRoute from './generic-route'
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'

#Rota privada. Todas as rotas que necessitam autenticação devem herdar. 

AbstractRoutesPrivateRouteRoute = AbstractRoutesGenericRouteRoute.extend(AuthenticatedRouteMixin,

)

export default AbstractRoutesPrivateRouteRoute
