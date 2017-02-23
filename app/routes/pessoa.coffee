import Ember from 'ember'

PessoaRoute = Ember.Route.extend(

  model: (params, transition) ->
    return @get("store").findRecord("pessoa", transition.params.pessoa.id)

  actions:

    actRedirecionar: (rota) ->
      @transitionTo(rota)
)

export default PessoaRoute
