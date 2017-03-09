import Ember from 'ember'
import FormsGenericFormComponent from './generic-form'
import RequestsTipoProdutoMixin from '../../mixins/requests/tipo-produto'
import UtilsMixin from '../../mixins/utils'

FormsNewTipoProdutoComponent = FormsGenericFormComponent.extend(RequestsTipoProdutoMixin, UtilsMixin,

  store: Ember.inject.service()

  isEdit: false

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

  #Array de flags de validacao dos produtos vinculados.
  validacoesProdutos: []

  #Indica qual produto esta sendo processado.
  produtoAbaAtual: null
  indexProdutoAbaAtual: null

  #Arrays de delecao para modo edicao
  produtosExcluidos: []
  fornecedoresExcluidos: []
  unidadesEntradaExcluidos: []

  #Flags de validacao do produto atual.
  validacoesProdutoAtual: Ember.computed("indexProdutoAbaAtual", ->
    return @get("validacoesProdutos").objectAt(@get("indexProdutoAbaAtual"))
  )

  #Flags de validacao dos fornecedores do produto atual
  validacoesFornecedoresProdutoAtual: Ember.computed("indexProdutoAbaAtual", ->
    return @get("validacoesProdutos").objectAt(@get("indexProdutoAbaAtual"))["validacoesFornecedores"]
  )

  #Flags de validacao das unidades de entrada do produto atual
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

  #Ao receber os atributos do controlador:
  didReceiveAttrs: (args) ->
    @_super()

    #Inicializa o array de validacao de produtos.
    @inicializarArrayValidacaoProdutos()

    #Se é um novo cadastro:
    if !@get("isEdit")

      #Vincula um novo produto ao tipo de produto.
      @criarProduto()

    else

      #Considera os campos iniciais válidos.
      @set("mnemonicoValido", true)
      @set("nomeValido", true)
      @set("descricaoValida", true)
      @set("categoriaValida", true)
      @set("unidadeDeSaidaValida", true)
      @set("estoqueMinimoValido", true)
      @set("pontoDeCompraValido", true)
      @set("estoqueIdealValido", true)
      @set("statusValido", true)

  #Ao componente ser inserido na DOM:
  didInsertElement: ->

    self = @

    @_super()

    @set("messageBox", @$("#box-alert").find(".alert"))

    #Simula o clique na aba para o formulario de produto ser visivel.
    @$("#btn-aba-produto-0").trigger("click")

    #Se modo edição:
    if @get("isEdit")
      @$("#cmb-tipo-produto-status").val(@get("tipoProduto").get("status"))

      @get("tipoProduto.produtos").forEach(
        (p, index) ->
          if p.get("isNew")
            return

          self.$("#div-produto-#{index}-status").find("select").val(p.get("status"))

      )

  #Inicializa o array de validacao de produtos.
  inicializarArrayValidacaoProdutos: ->

    self = @

    validacoesProduto = []

    if @get("isEdit")

      produtos = @get("tipoProduto.produtos").forEach(

        (produto) ->

          validacaoProduto = self.criarObjetoInicialValidacaoProduto()
          validacaoProduto["nomeValido"]   = true
          validacaoProduto["statusValido"] = true
          validacaoProduto["marcaValida"]  = true

          unidadesEntrada = produto.get("unidadesMedidaEntrada")

          if unidadesEntrada && unidadesEntrada.get("length") > 0

            unidadesEntrada.forEach(
              (unidade) ->
                validacaoUnidade                     = self.criarObjetoInicialValidacaoUnidadeEntrada()
                validacaoUnidade["nomeValido"]       = true
                validacaoUnidade["quantidadeValida"] = true
                validacaoProduto["validacoesUnidadeEntrada"].pushObject(validacaoUnidade)
            )


          fornecedores = produto.get("fornecedores")

          if fornecedores && fornecedores.get("length") > 0

            fornecedores.forEach(
              (unidade) ->
                validacaoFornecedor               = self.criarObjetoInicialValidacaoFornecedorProduto()
                validacaoFornecedor["nomeValido"] = true
                validacaoProduto["validacoesFornecedores"].pushObject(validacaoFornecedor)
            )

          validacoesProduto.pushObject(validacaoProduto)

      )

    @set("validacoesProdutos", validacoesProduto)

  #Cria um novo produto vinculado ao tipo de produto.
  criarProduto: (nome = "Novo produto") ->
    tipoProduto = @get("tipoProduto")
    produto     = @get("store").createRecord("produto")
    produto.set("nome", nome)
    tipoProduto.get("produtos").pushObject(produto)

    #Cria um objeto de validacao referente ao produto criado e adiciona no array
    #de flags de validacao de produtos.
    validacoesProdutos = @get("validacoesProdutos")
    validacoesProdutos.push(@criarObjetoInicialValidacaoProduto())

  #Cria um objeto inicial de flags de validacao de produtos.
  criarObjetoInicialValidacaoProduto: ->

    retorno =
      {
        nomeValido: false
        statusValido: false
        marcaValida: true
        validacoesFornecedores: []
        validacoesUnidadeEntrada: []
      }

    return retorno

  #Cria um objeto inicial de flags de validacao de fornecedor do produto.
  criarObjetoInicialValidacaoFornecedorProduto: ->

    retorno =
      nomeValido: false

    return retorno

  #Cria um objeto inicial de flags de validacao de unidade de entrada do produto.
  criarObjetoInicialValidacaoUnidadeEntrada: ->

    retorno =
      nomeValido: false
      quantidadeValida: false

    return retorno

  #Valida o formulario.
  validate: (callbackAfterValidate) ->

    self = @

    arrayMensagensErro = []
    valido = true

    #Valida os campos do Tipo de Produto
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

    #Valida os campos de cada aba de produto:
    @get("validacoesProdutos").forEach(

      (validacao, indexProduto) ->

        produto = self.get("tipoProduto.produtos").objectAt(indexProduto)

        if self.get("produtosExcluidos").indexOf(produto) > -1
          return

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

        #Valida os campos dos fornecedores vinculados ao produto.
        validacao["validacoesFornecedores"].forEach(

          (v, indexFornecedor) ->

            fornecedor = produto.get("fornecedores").objectAt(indexFornecedor)

            if self.get("fornecedoresExcluidos").indexOf(fornecedor) > -1
              return

            fornecedor = fornecedor.get("pessoa")

            if !v["nomeValido"]
              errosProduto.push("Fornecedor <b>#{(indexFornecedor + 1)}</b>: você deve preencher corretamente o campo <b>Nome.</b>")
              valido = false
              produtoValido = false

        )

        #Valida os campos das unidades de entrada vinculadas ao produto.
        validacao["validacoesUnidadeEntrada"].forEach(

          (v, indexUnidadeEntrada) ->

            unidadeEntrada = produto.get("unidadesMedidaEntrada").objectAt(indexUnidadeEntrada)

            if self.get("unidadesEntradaExcluidos").indexOf(unidadeEntrada) > -1
              return

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

              errosProduto.push("Unidade de Entrada <b>#{nome}</b>: você deve preencher corretamente o campo <b>Quantidade.</b>")
              valido = false
              produtoValido = false

        )

        #Prepara a mensagem de erro do produto iterado.
        if errosProduto.length > 0

          if validacao["nomeValido"]
            nome = produto.get("nome")
          else
            nome = indexProduto + 1

          #Associa a mensagem do produto a variavel de mensagens final.
          stringFinalErros = stringFinalErros + "O produto <b>#{nome}</b> possui inconsistências: " + self.messageArrayToUlLiTags(errosProduto)

    )

    #Se o formulario é valido:
    if valido

      return @esconderMensagem({},
        ->
          callbackAfterValidate(true)
      )


    else
    #Se o formulario é inválido:

      return @mostrarMensagem(message: stringFinalErros, type: "danger",
        ->
          callbackAfterValidate(false)
      )

  #Ao submeter o formulario:
  submitForm: (callbackOnSubmitComplete) ->

    self = @

    if @get("isEdit")
      metodo   = @atualizarTipoProduto
      mensagem = "Tipo de produto atualizado com sucesso! <br> Você será redirecionado em instantes..."
      params   =
        tipoProduto: @get("tipoProduto")
        produtosExcluidos: @get("produtosExcluidos")
        fornecedoresExcluidos: @get("fornecedoresExcluidos")
        unidadesEntradaExcluidos: @get("unidadesEntradaExcluidos")
    else
      metodo   = @cadastrarTipoProduto
      mensagem = "Tipo de produto cadastrado com sucesso! <br> Você será redirecionado em instantes..."
      params   = tipoProduto: @get("tipoProduto")

    #Tenta cadastrar o novo tipo de produto.
    metodo(@, params).then(

      #Sucesso no submit:
      (marca) ->

        #Se cadastrado com sucesso exibe a mensagem de sucesso e apos 3s
        #chama a action de redirecionamento.
        self.mostrarMensagem(message: mensagem, type: "success",

          ->
            setTimeout(
              ->
                self.sendAction("actionOnSubmitted")
                callbackOnSubmitComplete(true)
              3000
            )

        )

      #Erro no submit:
      (errs) ->

        #Mostra mensagem de erro.
        self.mostrarMensagem(message: "Ocorreu um erro.", type: "danger",
          ->
            callbackOnSubmitComplete(false)
        )

    )

  #Override do metodo da superclasse para alem de mostrar a mensagem, tambem
  #mover o cursor.
  mostrarMensagem: (options, callbackOnAnimationComplete) ->

    self = @
    messageBox = @get("messageBox")

    @_super(options,
      ->
        self.moverScrollComAnimacao(messageBox)
        callbackOnAnimationComplete()
    )

  indicarDelecaoProduto: (indicar, tipoProduto, index) ->

    self = @

    exclamacaoAba   = @$("#i-delecao-produto-" + tipoProduto.get("id"))
    mensagemAlerta  = @$("#mensagem-delecao-produto-" + tipoProduto.get("id"))
    componentesForm = @$("#tab-produto-" + index).find("*")
    botaoFechar     = @$("#btn-fechar-produto-" + index)

    metodo = if indicar then "show" else "hide"

    exclamacaoAba[metodo]()
    mensagemAlerta[metodo]()
    componentesForm.attr("disabled", indicar)

    if indicar
      botaoFechar.hide()
    else
      @get("fornecedoresExcluidos").forEach(
        (f) ->
          i = self.get("produtoAbaAtual").get("fornecedores").indexOf(f)
          self.indicarDelecaoFornecedor(true, i, f)
      )

      @get("unidadesEntradaExcluidos").forEach(
        (u) ->
          i = self.get("produtoAbaAtual").get("unidadesMedidaEntrada").indexOf(u)
          self.indicarDelecaoUnidade(true, i, u)
      )

      botaoFechar.show()

  indicarDelecaoFornecedor: (indicar, index, fornecedor) ->

    indexProduto = @get("indexProdutoAbaAtual")

    componentesForm = @$("#componentes-produto-#{indexProduto}-fornecedor-#{index}").find("*")
    mensagemAlerta  = @$("#mensagem-delecao-produto-#{indexProduto}-fornecedor-#{index}")
    botoesControle  = @$("#botoes-controle-produto-#{indexProduto}-fornecedor-#{index}")

    componentesForm.attr("disabled", indicar)

    if indicar
      mensagemAlerta.show()
      botoesControle.hide()
    else
      mensagemAlerta.hide()
      botoesControle.show()

  indicarDelecaoUnidade: (indicar, index, unidade) ->

    indexProduto = @get("indexProdutoAbaAtual")

    componentesForm = @$("#componentes-produto-#{indexProduto}-unidade-#{index}").find("*")
    mensagemAlerta  = @$("#mensagem-delecao-produto-#{indexProduto}-unidade-#{index}")
    botoesControle  = @$("#botoes-controle-produto-#{indexProduto}-unidade-#{index}")

    componentesForm.attr("disabled", indicar)

    if indicar
      mensagemAlerta.show()
      botoesControle.hide()
    else
      mensagemAlerta.hide()
      botoesControle.show()

  atualizarOrdenacaoUnidades: ->

    @get("produtoAbaAtual.unidadesMedidaEntrada").forEach(
      (u, index) ->
        u.set("ordem", (index + 1))
    )
  actions:

    #Action ao clicar no botao para criar novo produto.
    actCriarNovaAbaProduto: ->

      self = @

      tipoProduto = @get("tipoProduto")
      produtos    = tipoProduto.get("produtos")

      @criarProduto("Novo produto" + " " + (produtos.get("length") + 1))

      #Determina o index final para determinar o botao de clique da aba.
      index = produtos.get("length") - 1

      #Tenta obter o botao da aba que se refere ao produto criado.
      btn = @$("#btn-aba-produto-#{index}")

      #Simula o clique na aba referente ao produto criado para o formulario
      #atual ser o do novo produto criado.
      if btn.length == 0
        setTimeout(->
          self.$("#btn-aba-produto-#{index}").trigger("click")
          125
        )
      else
        btn.trigger("click")

    #Action ao fechar a aba de algum produto.
    actFecharAbaProduto: (index) ->

      produtos = @get("tipoProduto").get("produtos")

      #Se existe somente 1 produto nao deve excluir.
      if produtos.get("length") == 1
        return

      #Obtem o produto a ser excluido.
      produto = produtos.objectAt(index)

      #Se é modo edicao e o produto nao é um novo produto:
      if @get("isEdit") && !produto.get("isNew")

        @get("produtosExcluidos").pushObject(produto)

        @indicarDelecaoProduto(true, produto, index)

      else

        #Remove do array hasMany.
        @get("tipoProduto").get("produtos").removeAt(index)

        #Remove do Ember-Data.
        @get("store").unloadRecord(produto)

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

        #Remove o objeto de validacao do produto.
        @get("validacoesProdutos").removeAt(index)

    actCancelarExclusaoProduto: (index, produto) ->

      @get("produtosExcluidos").removeObject(produto)
      @indicarDelecaoProduto(false, produto, index)

    #Adiciona um novo fornecedor para o produto atual em processamento.
    actAdicionarFornecedor: (produto) ->
      fornecedores = produto.get("fornecedores")
      fornecedores.pushObject(@get("store").createRecord("fornecedor-produto"))

      validacoesFornecedores = @get("validacoesFornecedoresProdutoAtual")
      validacoesFornecedores.pushObject(@criarObjetoInicialValidacaoFornecedorProduto())

    #Adiciona uma nova unidade de entrada para o produto atual em processamento.
    actAdicionarUnidadeEntrada: (produto) ->
      unidadesEntrada = produto.get("unidadesMedidaEntrada")
      unidadesEntrada.pushObject(@get("store").createRecord("unidade-medida-entrada", ordem: (unidadesEntrada.get("length") + 1)))

      validacoesUnidadeEntrada = @get("validacoesUnidadeEntradaProdutoAtual")
      validacoesUnidadeEntrada.pushObject(@criarObjetoInicialValidacaoUnidadeEntrada())

    #Exclui um fornecedor vinculado ao produto.
    actExcluirLinhaFornecedor: (produto, index, fornecedor) ->

      if @get("isEdit") && !fornecedor.get("isNew")

        @indicarDelecaoFornecedor(true, index, fornecedor)
        @get("fornecedoresExcluidos").pushObject(fornecedor)
      else

        produto.get("fornecedores").removeObject(fornecedor)

        validacoesFornecedores = @get("validacoesFornecedoresProdutoAtual")
        validacoesFornecedores.removeAt(index)

    actCancelarExclusaoFornecedor: (fornecedor, indexFornecedor) ->
      @get("fornecedoresExcluidos").removeObject(fornecedor)
      @indicarDelecaoFornecedor(false, indexFornecedor, fornecedor)

    #Exclui uma unidade de entrada vinculado ao produto.
    actExcluirLinhaUnidadeEntrada: (produto, index, unidadeEntrada) ->

      if @get("isEdit") && !unidadeEntrada.get("isNew")

        @indicarDelecaoUnidade(true, index, unidadeEntrada)
        @get("unidadesEntradaExcluidos").pushObject(unidadeEntrada)

      else

        produto.get("unidadesMedidaEntrada").removeObject(unidadeEntrada)

        validacoesUnidadeEntrada = @get("validacoesUnidadeEntradaProdutoAtual")
        validacoesUnidadeEntrada.removeAt(index)

    actCancelarExclusaoUnidade: (unidade, indexUnidade) ->
      @get("unidadesEntradaExcluidos").removeObject(unidade)
      @indicarDelecaoUnidade(false, indexUnidade, unidade)

    #Move uma unidade de entrada para cima.
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
      @atualizarOrdenacaoUnidades()

    #Move uma nidade de entrada para baixo.
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
      @atualizarOrdenacaoUnidades()


    #Indica qual é o produto atual apos clicar em alguma aba de produtos.
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

    actValidarCategoria: (params) ->

      record = params["record"]
      valido = if record == null then false else true

      @set("tipoProduto.categoriaProduto", record)
      @set("categoriaValida", valido)

    actValidarUnidadeSaida: (params) ->

      record = params["record"]
      valido = if record == null then false else true

      @set("tipoProduto.unidadeMedidaSaida", record)
      @set("unidadeDeSaidaValida", valido)


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

    actValidarMarca: (params) ->

      record = params["record"]
      valido = true

      produto = @set("produtoAbaAtual.marca", record)

    actValidarNomeUnidadeMedidaProduto: (params) ->

      index  = params["refIndex"]
      record = params["record"]
      valido = if record == null then false else true

      validacoes = @get("validacoesUnidadeEntradaProdutoAtual")
      validacao  = validacoes.objectAt(index)

      validacao["nomeValido"] = valido
      validacoes.insertAt(index, validacao)
      validacoes.removeAt((index + 1))

      unidades = @get("produtoAbaAtual.unidadesMedidaEntrada")
      unidade  = unidades.objectAt(index)
      unidade.set("unidadeMedida", record)

    actValidarNomeFornecedor: (params) ->

      index  = params["refIndex"]
      record = params["record"]
      valido = if record == null then false else true

      validacoes = @get("validacoesFornecedoresProdutoAtual")
      validacao  = validacoes.objectAt(index)

      validacao["nomeValido"] = valido
      validacoes.insertAt(index, validacao)
      validacoes.removeAt((index + 1))

      fornecedores = @get("produtoAbaAtual.fornecedores")
      fornecedor   = fornecedores.objectAt(index)
      fornecedor.set("pessoa", record)

)

export default FormsNewTipoProdutoComponent
