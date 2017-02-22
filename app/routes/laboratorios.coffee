import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from './abstract-routes/private-route'

LaboratoriosRoute = AbstractRoutesPrivateRouteRoute.extend(

  applicationSession: Ember.inject.service()

  model: (params, transition) ->

    params = @paramsToUseQueryAsFindAll(transition.queryParams)

    laboratorios =  @get("store").query("laboratorio", params)

    laboratorioAtual = @get("applicationSession").obterLaboratorioAtualUsuario()

    return Ember.RSVP.hash(
      laboratorios: laboratorios
      laboratorioAtual: laboratorioAtual
    )

  setupController: (controller, model) ->
    @_super(controller, model)
    @setupControllerWithPagination(controller, model["laboratorios"])

)

export default LaboratoriosRoute
