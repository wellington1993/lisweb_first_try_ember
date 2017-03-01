import Ember from 'ember'
import FormsGenericFormComponent from './generic-form'

FormsNewTipoProdutoComponent = FormsGenericFormComponent.extend(

  store: Ember.inject.service()

  #Flags de validacao do tipo do produto
  mnemonicoValido: false
  nomeValido: false
  descricaoValida: false
  categoriaValida: false
  unidadeDeSaidaValida: false
  estoqueMinimoValido: false
  pontoDeCompraValido: false
  estoqueIdealValido: false
  statusValido: false
  validacoesProdutos: []

  produtoAbaAtual: null
  indexProdutoAbaAtual: null

  validacoesProdutoAtual: Ember.computed("indexProdutoAbaAtual", ->
    return @get("validacoesProdutos").objectAt(@get("indexProdutoAbaAtual"))
  )

  validacoesFornecedoresProdutoAtual: Ember.computed("indexProdutoAbaAtual", ->
    return @get("validacoesProdutos").objectAt(@get("indexProdutoAbaAtual"))["validacoesFornecedores"]
  )

  validacoesUnidadeEntradaProdutoAtual: Ember.computed("indexProdutoAbaAtual", ->
    return @get("validacoesProdutos").objectAt(@get("indexProdutoAbaAtual"))["validacoesUnidadeEntrada"]
  )

  #Indica se o Tipo de Produto possui apenas 1 produto vinculado.
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

    @inicializarArrayValidacao()

    #Vincula um novo produto ao tipo de produto.
    @criarProduto()

  didInsertElement: ->
    @_super()

    #Simula o clique na aba para o formulario de produto ser visivel.
    @$("#btn-aba-produto-0").trigger("click")

  inicializarArrayValidacao: ->
    @set("validacoesProdutos", [])

  criarProduto: (nome = "Novo produto") ->
    tipoProduto = @get("tipoProduto")
    produto     = @get("store").createRecord("produto")
    produto.set("nome", nome)
    tipoProduto.get("produtos").pushObject(produto)

    validacoesProdutos = @get("validacoesProdutos")
    validacoesProdutos.push(@criarObjetoInicialValidacaoProduto())

  criarObjetoInicialValidacaoProduto: ->

    retorno =
      {
        nomeValido: false
        statusValido: false
        marcaValida: false
        validacoesFornecedores: []
        validacoesUnidadeEntrada: []
      }

    return retorno

  criarObjetoInicialValidacaoFornecedorProduto: ->

    retorno =
      nomeValido: false

    return retorno

  criarObjetoInicialValidacaoUnidadeEntrada: ->

    retorno =
      nomeValido: false
      quantidadeValida: false

    return retorno

  validate: (callbackAfterValidate) ->

    self = @

    arrayMensagensErro = []
    valido = true

    if !@get("mnemonicoValido")
      valido = false
      arrayMensagensErro.push("Você deve preencher o campo <b>Mnemônico.</b>")

    if !@get("nomeValido")
      valido = false
      arrayMensagensErro.push("Você deve preencher o campo <b>Nome.</b>")

    if !@get("descricaoValida")
      valido = false
      arrayMensagensErro.push("Você deve preencher o campo <b>Descrição.</b>")

    if !@get("categoriaValida")
      valido = false
      arrayMensagensErro.push("Você deve preencher o campo <b>Categoria.</b>")

    if !@get("unidadeDeSaidaValida")
      valido = false
      arrayMensagensErro.push("Você deve preencher o campo <b>Unidade de Saída.</b>")

    if !@get("estoqueMinimoValido")
      valido = false
      arrayMensagensErro.push("Você deve preencher corretamente o campo <b>Estoque Mínimo.</b>")

    if !@get("pontoDeCompraValido")
      valido = false
      arrayMensagensErro.push("Você deve preencher corretamente o campo <b>Ponto de Compra.</b>")

    if !@get("estoqueIdealValido")
      valido = false
      arrayMensagensErro.push("Você deve preencher corretamente o campo <b>Estoque Ideal.</b>")

    if !@get("statusValido")
      valido = false
      arrayMensagensErro.push("Você deve preencher corretamente o campo <b>Status.</b>")

    if arrayMensagensErro.length > 0
      stringFinalErros = @messageArrayToUlLiTags(arrayMensagensErro)
    else
      stringFinalErros = ""

    @get("validacoesProdutos").forEach(

      (validacao, indexProduto) ->

        produto = self.get("tipoProduto.produtos").objectAt(indexProduto)

        produtoValido = false

        errosProduto = []

        if !validacao["nomeValido"]
          errosProduto.push("Você deve preencher o campo <b>Nome.</b>")
          valido = false
          produtoValido = false

        if !validacao["marcaValida"]
          errosProduto.push("Você deve preencher o campo <b>Marca.</b>")
          valido = false
          produtoValido = false

        if !validacao["statusValido"]
          errosProduto.push("Você deve preencher o campo <b>Status.</b>")
          valido = false
          produtoValido = false

        validacao["validacoesFornecedores"].forEach(

          (v, indexFornecedor) ->

            fornecedor = produto.get("fornecedores").objectAt(indexFornecedor)
            fornecedor = fornecedor.get("pessoa")

            if !v["nomeValido"]
              errosProduto.push("Fornecedor <b>#{(indexFornecedor + 1)}</b>: você deve preencher corretamente o campo <b>Nome.</b>")
              valido = false
              produtoValido = false

        )

        validacao["validacoesUnidadeEntrada"].forEach(

          (v, indexUnidadeEntrada) ->

            unidadeEntrada = produto.get("unidadesMedidaEntrada").objectAt(indexUnidadeEntrada)
            unidadeEntrada = unidadeEntrada.get("unidadeMedida")

            if !v["nomeValido"]
              errosProduto.push("Unidade de Entrada <b>#{(indexUnidadeEntrada + 1)}</b>: você deve preencher corretamente o campo <b>Nome.</b>")
              valido = false
              produtoValido = false

            if !v["quantidadeValida"]

              if v["nomeValido"]
                nome = unidadeEntrada.get("nome")
              else
                nome = indexUnidadeEntrada + 1

              errosProduto.push("Unidade de entrada <b>#{nome}</b>: você deve preencher corretamente o campo <b>Quantidade.</b>")
              valido = false
              produtoValido = false

        )

        if errosProduto.length > 0

          if validacao["nomeValido"]
            nome = produto.get("nome")
          else
            nome = indexProduto + 1

          stringFinalErros = stringFinalErros + "O produto <b>#{nome}</b> possui inconsistências: " + self.messageArrayToUlLiTags(errosProduto)

    )

    if valido

      return @esconderMensagem({},
        ->
          callbackAfterValidate(true)
      )


    else

      return @mostrarMensagem(message: stringFinalErros, type: "danger",
        ->
          callbackAfterValidate(false)
      )

  actions:

    actCriarNovaAbaProduto: ->

      self = @

      tipoProduto = @get("tipoProduto")
      produtos    = tipoProduto.get("produtos")

      @criarProduto("Novo produto" + " " + (produtos.get("length") + 1))

      #Determina o index final para determinar o botao de clique da aba.
      index = produtos.get("length") - 1

      #Tenta obter o botao da aba que se refere ao produto criado.
      btn = @$("#btn-aba-produto-#{index}")

      #Simula o clique na aba referente ao produto criado para o formulario ser
      #visivel.
      if btn.length == 0
        setTimeout(->
          self.$("#btn-aba-produto-#{index}").trigger("click")
          125
        )

      else
        btn.trigger("click")

    actFecharAbaProduto: (index) ->

      produtos = @get("tipoProduto").get("produtos")

      #Se existe somente 1 produto nao deve excluir.
      if produtos.get("length") == 1
        return

      #Obtem o produto a ser excluido.
      produto = produtos.objectAt(index)

      #Remove do array hasMany.
      @get("tipoProduto").get("produtos").removeAt(index)

      #Remove do Ember-Data.
      @get("store").unloadRecord(produto)

      #Remove o objeto de validacao do produto.
      @get("validacoesProdutos").removeAt(index)

      #Obtem a aba ativa.
      abaAtiva = @$(".nav-tabs").find(".active")

      #Se nao ha aba ativa a aba do primeiro produto sera clicada.
      if !abaAtiva
        @$("#btn-aba-produto-0").trigger("click")
      else

        #Obtem o index do produto referente a aba atual
        indexAbaAtual = parseInt(abaAtiva.find("a").attr("id").split("-").get("lastObject"))

        #Se a aba atual é a aba a ser fechada:
        if indexAbaAtual == index

          #Se é a primeira aba, a segunda aba passará a ser a aba ativa.
          if index == 0
            indexAbaAtual = 1
          else
            #A aba anterior a aba a ser fechada será aba ativa.
            indexAbaAtual = indexAbaAtual - 1

          #Simula o evento click para que ao fechar a aba uma nova aba esteja
          #ativa.
          @$("#btn-aba-produto-#{indexAbaAtual}").trigger("click")

    actAdicionarFornecedor: (produto) ->
      fornecedores = produto.get("fornecedores")
      fornecedores.pushObject(@get("store").createRecord("fornecedor-produto"))

      validacoesFornecedores = @get("validacoesFornecedoresProdutoAtual")
      validacoesFornecedores.pushObject(@criarObjetoInicialValidacaoFornecedorProduto())

    actAdicionarUnidadeEntrada: (produto) ->
      unidadesEntrada = produto.get("unidadesMedidaEntrada")
      unidadesEntrada.pushObject(@get("store").createRecord("unidade-medida-entrada"))

      validacoesUnidadeEntrada = @get("validacoesUnidadeEntradaProdutoAtual")
      validacoesUnidadeEntrada.pushObject(@criarObjetoInicialValidacaoUnidadeEntrada())


    actExcluirLinhaFornecedor: (produto, index, fornecedor) ->
      produto.get("fornecedores").removeObject(fornecedor)

      validacoesFornecedores = @get("validacoesFornecedoresProdutoAtual")
      validacoesFornecedores.removeAt(index)

    actExcluirLinhaUnidadeEntrada: (produto, index, unidadeEntrada) ->
      produto.get("unidadesMedidaEntrada").removeObject(unidadeEntrada)

      validacoesUnidadeEntrada = @get("validacoesUnidadeEntradaProdutoAtual")
      validacoesUnidadeEntrada.removeAt(index)

    actMoverUnidadeCima: (produto, index, unidadeEntrada) ->

      if index == 0
        return

      unidades = produto.get("unidadesMedidaEntrada")
      unidades.removeObject(unidadeEntrada)
      unidades.insertAt((index - 1), unidadeEntrada)

      validacoesUnidadeEntrada = @get("validacoesUnidadeEntradaProdutoAtual")
      validacao = validacoesUnidadeEntrada.objectAt(index)
      validacoesUnidadeEntrada.removeAt(index)
      validacoesUnidadeEntrada.insertAt((index - 1), validacao)

    actMoverUnidadeBaixo: (produto, index, unidadeEntrada) ->

      unidades = produto.get("unidadesMedidaEntrada")

      if index == (unidades.get("length") - 1)
        return

      unidades.removeObject(unidadeEntrada)
      unidades.insertAt((index + 1), unidadeEntrada)

      validacoesUnidadeEntrada = @get("validacoesUnidadeEntradaProdutoAtual")
      validacao = validacoesUnidadeEntrada.objectAt(index)
      validacoesUnidadeEntrada.removeAt(index)
      validacoesUnidadeEntrada.insertAt((index + 1), validacao)

    actEscolherProdutoAbaAtual: (index, produto) ->
      @set("indexProdutoAbaAtual", index)
      @set("produtoAbaAtual", produto)

    ######################
    #Actions de validacao:
    ######################

    actValidarMnemonico: (params, callback) ->
      @set("mnemonicoValido", params["valido"])
      callback()

    actValidarNome: (params, callback) ->
      @set("nomeValido", params["valido"])
      callback()

    actValidarDescricao: (params, callback) ->
      @set("descricaoValida", params["valido"])
      callback()

    actValidarCategoria: (params, callback) ->
      @set("categoriaValida", params["valido"])
      callback()

    actValidarUnidadeSaida: (params, callback) ->
      @set("categoriaValida", params["valido"])
      callback()

    actValidarEstoqueMinimo: (params, callback) ->

      valido = params["valido"]

      estoqueMinimo = @get("tipoProduto.estoqueMinimo")

      if valido && (!estoqueMinimo || estoqueMinimo <= 0)
        valido = false

      @set("estoqueMinimoValido", valido)
      callback()

    actValidarPontoCompra: (params, callback) ->

      valido = params["valido"]

      pontoCompra = @get("tipoProduto.pontoCompra")

      if valido && (!pontoCompra || pontoCompra <= 0)
        valido = false

      @set("pontoDeCompraValido", valido)
      callback()

    actValidarEstoqueIdeal: (params, callback) ->

      valido = params["valido"]

      estoqueIdeal = @get("tipoProduto.estoqueIdeal")

      if valido && (!estoqueIdeal || estoqueIdeal <= 0)
        valido = false

      @set("estoqueIdealValido", valido)
      callback()

    actValidarStatusTipoProduto: (status) ->

      valido = true

      if !status
        valido = false

      @set("statusValido", valido)
      @set("tipoProduto.status", status)

    actValidarNomeProduto: (params, callback) ->
      indexProdutoAbaAtual = @get("indexProdutoAbaAtual")

      validacoes = @get("validacoesProdutos")
      validacao  = validacoes.objectAt(indexProdutoAbaAtual)

      validacao["nomeValido"] = params["valido"]
      validacoes.insertAt(indexProdutoAbaAtual, validacao)
      validacoes.removeAt((indexProdutoAbaAtual + 1))

      callback()

    actValidarStatusProduto: (status) ->

      valido = true

      if !status
        valido = false

      indexProdutoAbaAtual = @get("indexProdutoAbaAtual")

      validacoes = @get("validacoesProdutos")
      validacao  = validacoes.objectAt(indexProdutoAbaAtual)

      validacao["statusValido"] = valido
      validacoes.insertAt(indexProdutoAbaAtual, validacao)
      validacoes.removeAt((indexProdutoAbaAtual + 1))

      @set("produtoAbaAtual.status", status)

    actValidarQuantidadeUnidadeEntrada: (params, callback) ->

      index      = params["refIndex"]
      unidade    = @get("produtoAbaAtual").get("unidadesMedidaEntrada").objectAt(index)
      quantidade = unidade.get("quantidade")

      validacoes = @get("validacoesUnidadeEntradaProdutoAtual")

      validacao  = validacoes.objectAt(index)

      valido = params["valido"]

      if valido && (!quantidade || quantidade <= 0)
        valido = false

      validacao["quantidadeValida"] = valido

      validacoes.insertAt(index, validacao)
      validacoes.removeAt((index + 1))

      callback()

)

export default FormsNewTipoProdutoComponent
