import Ember from 'ember'

CadastrarTipoDeProdutoRoute = Ember.Route.extend(

  model: ->

    return Ember.RSVP.hash(
      tipoProduto: @get("store").createRecord("tipo-produto")
    )

  actions:

    #Se o usuario nao salvou o tipo de produto, ao sair da rota o tipo do produto
    #e os registros não salvos devem ser removidos do Ember-Data.
    willTransition: ->

      store = @get("store")

      model = @controllerFor("cadastrar-tipo-de-produto").get("model")["tipoProduto"]


      if model.get("isNew")

        #Remove os registros de produtos não salvos.
        model.get("produtos").forEach(

          (produto) ->

            try
              if produto.get("isNew")
                store.unloadRecord(produto)
            catch e
        )

        #Remove o tipo de produto.
        store.unloadRecord(model)

    actRedirecionarAposCadastro: ->
      @transitionTo("tipos-de-produto")

)

export default CadastrarTipoDeProdutoRoute
