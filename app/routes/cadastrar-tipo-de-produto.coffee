import Ember from 'ember'

CadastrarTipoDeProdutoRoute = Ember.Route.extend(

  model: ->

    return Ember.RSVP.hash(
      tipoProduto: @get("store").createRecord("tipo-produto")
      categoriaProduto: @get("store").findAll("categoria-produto")
      marca: @get("store").findAll("marca")
      fornecedores: @get("store").findAll("pessoa")
      unidadesMedida: @get("store").findAll("unidade-medida")
    )

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
