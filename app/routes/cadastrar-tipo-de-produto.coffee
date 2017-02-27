import Ember from 'ember'

CadastrarTipoDeProdutoRoute = Ember.Route.extend(

  model: ->
    return @get("store").createRecord("tipo-produto")


  actions:

    willTransition: ->
      model = @controllerFor("cadastrar-tipo-de-produto").get("model")

      if model.get("isNew")
        @get("store").unloadRecord(model)


)

export default CadastrarTipoDeProdutoRoute
