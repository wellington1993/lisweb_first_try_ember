import Ember from 'ember'

CadastrarTipoDeProdutoRoute = Ember.Route.extend(

  model: ->
    return @get("store").createRecord("tipo-produto")


  actions:

    willTransition: ->

      store = @get("store")

      model = @controllerFor("cadastrar-tipo-de-produto").get("model")

      if model.get("isNew")


        model.get("produtos").forEach(

          (produto) ->

            try
              if produto.get("isNew")
                store.unloadRecord(produto)
            catch e
        )

        store.unloadRecord(model)


)

export default CadastrarTipoDeProdutoRoute
