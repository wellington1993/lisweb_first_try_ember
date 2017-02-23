import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

PessoasShowRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->

    self = @

    pessoa      = @get("store").findRecord("pessoa", params["pessoa_id"]).then(
      (data) ->
        return data
      (err) ->

        self.transitionTo("pessoas")

    )
    tiposPessoa = @get("store").findAll("tipo-pessoa")

    return Ember.RSVP.hash(
      pessoa: pessoa
      tiposPessoa: tiposPessoa
    )

)

export default PessoasShowRoute
