import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from './abstract-routes/private-route'

UnidadesDeMedidaRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->

    params = @paramsToUseQueryAsFindAll(transition.queryParams)

    return @get("store").query("unidade-medida", params)

  setupController: (controller, model) ->
    @_super(controller, model)
    @setupControllerWithPagination(controller, model)


)

export default UnidadesDeMedidaRoute
