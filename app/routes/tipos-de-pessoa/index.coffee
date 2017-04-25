import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

TiposDePessoaIndexRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->

    params = @paramsToUseQueryAsFindAll(transition.queryParams)

    return @get("store").query("tipo-pessoa", params)

  setupController: (controller, model) ->
    @_super(controller, model)
    @setupControllerWithPagination(controller, model)


)

export default TiposDePessoaIndexRoute
