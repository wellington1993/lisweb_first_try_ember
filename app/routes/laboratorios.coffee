import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from './abstract-routes/private-route'

LaboratoriosRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->

    params = @paramsToUseQueryAsFindAll(transition.queryParams)

    return @get("store").query("laboratorio", params)

  setupController: (controller, model) ->
    @_super(controller, model)
    @setupControllerWithPagination(controller, model)

    laboratorioAtual = @controllerFor("application").get("model")
    controller.set("laboratorioAtual", laboratorioAtual)

)

export default LaboratoriosRoute
