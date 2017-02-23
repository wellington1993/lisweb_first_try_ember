import Ember from 'ember'

PessoaIndexRoute = Ember.Route.extend(

  beforeModel: (transition) ->
    @transitionTo("pessoa.identificacao", transition.params.pessoa.id)

)

export default PessoaIndexRoute
