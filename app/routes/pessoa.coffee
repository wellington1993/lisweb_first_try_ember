import Ember from 'ember'

PessoaRoute = Ember.Route.extend(

  model: (params, transition) ->
    return @get("store").findRecord("pessoa", transition.params.pessoa.id)

  actions:

    willTransition: (transition) ->

      if transition.targetName.substring(0,7) != "pessoa."

        model = @controllerFor("pessoa").get("model")

        if model
          model.rollbackAttributes()

    actRedirecionar: (rota) ->
      @transitionTo(rota)
)

export default PessoaRoute
