import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

GruposParametrosChaveShowRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->
    self = @
    grupoParametroChave =
      @get("store").findRecord("grupo-parametro-chave", params["grupo_parametro_id"], reload: true).then(
        (data) ->
          return data
        (err) ->
          self.transitionTo("grupos-parametros-chave/index")
       )
     return grupoParametroChave

  actions:
    #Se os atributos foram alterados e não salvos ao sair da rota as alterações
    #devem ser desfeitas.
    willTransition: ->
      @controllerFor("grupos-parametros-chave/show").get("model").rollbackAttributes()

    actRedirecionar: ->
      @transitionTo("grupos-parametros-chave/index")
)

export default GruposParametrosChaveShowRoute
