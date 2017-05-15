import Ember from 'ember'
import AbstractRoutesGenericRouteRoute from './generic-route'

#Rota pública. Todas as rotas que não necessitam de autenticação devem herdar.

AbstractRoutesPublicRouteRoute = AbstractRoutesGenericRouteRoute.extend()

export default AbstractRoutesPublicRouteRoute
