import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

MarcasShowRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->

    self = @

    marca =
      @get("store").findRecord("marca", params["marca_id"], reload: true).then(

        (data) ->
          return data

        (err) ->
          self.transitionTo("marcas/index")

       )

     return marca

  actions:

    #Se os atributos foram alterados e não salvos ao sair da rota as alterações
    #devem ser desfeitas.
    willTransition: ->
      @controllerFor("marcas/show").get("model").rollbackAttributes()

    actRedirecionar: ->
      @transitionTo("marcas/index")

)

export default MarcasShowRoute
