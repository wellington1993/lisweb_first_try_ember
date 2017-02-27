import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from './abstract-routes/private-route'

TiposDeProdutoRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->

    params = @paramsToUseQueryAsFindAll(transition.queryParams)

    return @get("store").query("tipo-produto", params)

  setupController: (controller, model) ->
    @_super(controller, model)
    @setupControllerWithPagination(controller, model)


)

export default TiposDeProdutoRoute
