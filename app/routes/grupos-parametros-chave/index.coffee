import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

GruposParametrosChaveIndexRoute = AbstractRoutesPrivateRouteRoute.extend(
  model: (params, transition) ->
    params = @paramsToUseQueryAsFindAll(transition.queryParams)
    return @get("store").query("grupo-parametro-chave", params)

  setupController: (controller, model) ->
    @_super(controller, model)
    @setupControllerWithPagination(controller, model)
)

export default GruposParametrosChaveIndexRoute
