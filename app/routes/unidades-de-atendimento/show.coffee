import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

UnidadesAtendimentoShowRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->
    self = @
    Nome =
      @get("store").findRecord("unidade-atendimento", params["unidade_atendimento_id"], reload: true).then(
        (data) ->
          return data
        (err) ->
          self.transitionTo("unidades-atendimento")
       )
     return Nome

  actions:
    #Se os atributos foram alterados e não salvos ao sair da rota as alterações
    #devem ser desfeitas.
    willTransition: ->
      @controllerFor("unidades-atendimento.show").get("model").rollbackAttributes()

    actRedirecionar: ->
      @transitionTo("unidades-atendimento")
)

export default UnidadesAtendimentoShowRoute
