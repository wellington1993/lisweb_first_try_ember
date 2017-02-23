import Ember from 'ember'

PessoaRoute = Ember.Route.extend(

  actions:

    actRedirecionar: (rota) ->
      @transitionTo(rota)
)

export default PessoaRoute
