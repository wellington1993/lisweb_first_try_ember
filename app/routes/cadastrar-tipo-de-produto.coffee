import Ember from 'ember'

CadastrarTipoDeProdutoRoute = Ember.Route.extend(

  model: ->

    return Ember.RSVP.hash(
      tipoProduto: @get("store").createRecord("tipo-produto")
    )

  actions:

    willTransition: ->

      store = @get("store")

      model = @controllerFor("cadastrar-tipo-de-produto").get("model")["tipoProduto"]

      if model.get("isNew")


        model.get("produtos").forEach(

          (produto) ->

            try
              if produto.get("isNew")
                store.unloadRecord(produto)
            catch e
        )

        store.unloadRecord(model)

    actRedirecionarAposCadastro: ->
      @transitionTo("tipos-de-produto")

)

export default CadastrarTipoDeProdutoRoute
