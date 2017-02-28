import Ember from 'ember'

FormsNewTipoProdutoComponent = Ember.Component.extend(

  store: Ember.inject.service()

  possuiUnicoProduto: Ember.computed("tipoProduto.produtos.length",
    ->

      retorno = true

      try
        length = @get("tipoProduto.produtos.length")
        if length > 1
          retorno = false
      catch e

      return retorno
  )

  didReceiveAttrs: (args) ->
    @_super()
    @criarProdutoInicial()

  didInsertElement: ->

    @$("#btn-aba-produto-0").trigger("click")

  criarProdutoInicial: ->

    tipoProduto = @get("tipoProduto")

    produto = @get("store").createRecord("produto")

    produto.set("nome", "Novo produto")

    tipoProduto.get("produtos").pushObject(produto)

  actions:

    actCriarNovaAbaProduto: ->

      self = @

      tipoProduto = @get("tipoProduto")

      produto = @get("store").createRecord("produto")

      produtos = tipoProduto.get("produtos")

      produto.set("nome", "Novo produto" + " " + (produtos.get("length") + 1))

      produtos.pushObject(produto)

      index = produtos.get("length") - 1

      btn = @$("#btn-aba-produto-#{index}")

      if btn.length == 0
        setTimeout(->
          self.$("#btn-aba-produto-#{index}").trigger("click")
          125
        )
      else
        btn.trigger("click")

    actFecharAbaProduto: (index) ->

      produtos = @get("tipoProduto").get("produtos")

      if produtos.get("length") == 1
        return

      produto = produtos.objectAt(index)

      @get("tipoProduto").get("produtos").removeAt(index)

      @get("store").unloadRecord(produto)

    actAdicionarFornecedor: (produto) ->

      fornecedores = produto.get("fornecedores")
      fornecedores.pushObject(@get("store").createRecord("fornecedor-produto"))

    actAdicionarUnidadeEntrada: (produto) ->
      unidadesEntrada = produto.get("unidadesMedidaEntrada")
      unidadesEntrada.pushObject(@get("store").createRecord("unidade-medida-entrada"))

    actExcluirLinhaFornecedor: (produto, index, fornecedor) ->
      produto.get("fornecedores").removeObject(fornecedor)

    actExcluirLinhaUnidadeEntrada: (produto, index, unidadeEntrada) ->
      produto.get("unidadesMedidaEntrada").removeObject(unidadeEntrada)

    actMoverUnidadeCima: (produto, index, unidadeEntrada) ->

      if index == 0
        return

      unidades = produto.get("unidadesMedidaEntrada")

      unidades.removeObject(unidadeEntrada)

      unidades.insertAt((index - 1), unidadeEntrada)

    actMoverUnidadeBaixo: (produto, index, unidadeEntrada) ->

      unidades = produto.get("unidadesMedidaEntrada")

      if index == (unidades.get("length") - 1)
        return

      unidades.removeObject(unidadeEntrada)

      unidades.insertAt((index + 1), unidadeEntrada)

)

export default FormsNewTipoProdutoComponent
