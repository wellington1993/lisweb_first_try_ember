import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

PessoasShowRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->

    self = @

    pessoa      = @get("store").findRecord("pessoa", params["pessoa_id"], reload: true).then(
      (data) ->
        return data
      (err) ->

        self.transitionTo("pessoas")

    )
    tiposPessoa = @get("store").findAll("tipo-pessoa", reload: true)

    return Ember.RSVP.hash(
      pessoa: pessoa
      tiposPessoa: tiposPessoa
    )

  actions:

    willTransition: ->
      @controllerFor("pessoas.show").get("model")["pessoa"].rollbackAttributes()

    actRedirecionar: ->
      @transitionTo("pessoas")

)

export default PessoasShowRoute
