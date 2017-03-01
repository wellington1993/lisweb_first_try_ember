import Ember from 'ember'
import FormsGenericFormComponent from './generic-form'
import RequestsPessoaMixin from '../../mixins/requests/pessoa'

FormsNewPessoaComponent = FormsGenericFormComponent.extend(RequestsPessoaMixin,

  store: Ember.inject.service()

  #Atributos provenientes do contexto externo.
  model: null
  tiposPessoa: null

  #Atributos de mascara da primeira aba.
  cnpj: null
  cpf: null

  #Atributos de mascara da segunda aba.
  telefone: null
  celular: null
  fax: null

  #Atributos de mascara da terceira aba.
  cep: null

  #Flags de validacao da primeira aba.
  tipoValido: false
  nomeValido: false
  cnpjValido: false
  cpfValido: false

  #Flags de validacao da segunda aba.
  emailValido: false
  telefoneValido: false
  celularValido: false
  faxValido: false

  #Flags de validacao da terceira aba.
  cepValido: false

  #Array para popular o select-options de tipo de pessoa.
  arraySelectOptionsTipoPessoa: Ember.computed("tiposPessoa", ->

    tiposPessoa = @get("tiposPessoa")

    if !tiposPessoa
      return tiposPessoa

    arrayFinal = []

    tiposPessoa.forEach(
      (tipoPessoa) ->
        arrayFinal.push(title: tipoPessoa.get("nome"), value: tipoPessoa.get("id"))
    )

    return arrayFinal

  )

  didReceiveAttrs: (args) ->
    @_super(args)

    #Se é modo edicao inicializa os campos que utilizam mascara.
    if @get("isEdit")
      @set("cnpj", @get("model.cnpj"))
      @set("cpf", @get("model.cpf"))
      @set("cep", @get("model.cep"))
      @set("telefone", @get("model.telefone"))
      @set("celular", @get("model.celular"))
      @set("fax", @get("model.fax"))
    else
      @set("cnpjValido", true)
      @set("cpfValido", true)
      @set("emailValido", true)
      @set("telefoneValido", true)
      @set("celularValido", true)
      @set("faxValido", true)
      @set("cepValido", true)

  didInsertElement: ->
    @_super()

    #Se é modo edicao:
    if @get("isEdit")
      @inicializarModoEdicao()

  #Método de validação do formulário.
  validate: (callbackAfterValidate) ->

    self = @

    errosAbaIdentificacao = []
    errosAbaContato       = []
    errosAbaEnderecamento = []

    valido = true

    #Valida a primeira aba:
    if !@get("tipoValido")
      errosAbaIdentificacao.push("Não foi escolhido nenhum tipo de pessoa")
      valido = false

    else

      #Se é pessoa fisica:
      if @get("model").get("tipoPessoa").get("isPessoaFisica")

        if !@get("cpfValido")
          errosAbaIdentificacao.push("O CPF foi preenchido incorretamente.")
          valido = false

        if !@get("nomeValido")
          errosAbaIdentificacao.push("O nome deve ser preenchido.")
          valido = false

      #Se pessoa jurídica
      else

        if !@get("cnpjValido")
          errosAbaIdentificacao.push("O CNPJ foi preenchido incorretamente.")
          valido = false

        if !@get("nomeValido")
          errosAbaIdentificacao.push("O nome fantasia deve ser preenchido.")
          valido = false

    #Valida a aba de contatos.
    if !@get("emailValido")
      errosAbaContato.push("O e-mail foi preenchido incorretamente.")
      valido = false

    if !@get("telefoneValido")
      errosAbaContato.push("O telefone foi preenchido incorretamente.")
      valido = false

    if !@get("celularValido")
      errosAbaContato.push("O celular foi preenchido incorretamente.")
      valido = false

    if !@get("faxValido")
      errosAbaContato.push("O fax foi preenchido incorretamente.")
      valido = false

    #Valida a aba de enderecamento.
    if !@get("cepValido")
      errosAbaEnderecamento.push("O CEP foi preenchido incorretamente.")
      valido = false

    if valido
      return @esconderMensagem({},
        ->
          callbackAfterValidate(valido)
      )

    mensagemFinal = ""

    #Se ha erros na aba identificacao:
    if errosAbaIdentificacao.length > 0
      mensagemFinal = "<span>Aba <b>identificação:</b></span>" + @messageArrayToUlLiTags(errosAbaIdentificacao)

    #Se ha erros na aba contato:
    if errosAbaContato.length > 0
      mensagemFinal = mensagemFinal + "<span>Aba <b>contato:</b></span>" + @messageArrayToUlLiTags(errosAbaContato)

    #Se ha erros na aba enderecamento:
    if errosAbaEnderecamento.length > 0
      mensagemFinal = mensagemFinal + "<span>Aba <b>endereçamento:</b></span>" + @messageArrayToUlLiTags(errosAbaEnderecamento)

    @mostrarMensagem(message: mensagemFinal, type: "danger",
      ->
        return callbackAfterValidate(valido)
    )


  inicializarModoEdicao: ->

    #Obtem o model do componente.
    model = @get("model")

    #Inicializa o select-options de tipo de pessoa.
    @$("#cmb-tipo-pessoa").val(model.get("tipoPessoa").get("id"))
    @$("#cmb-tipo-pessoa").trigger("change")

    #Forca o evento change dos atributos que utilizam validacoes de mascara para
    #a validacao ser realizada na inicializacao.
    @$("#txt-nome-pj").trigger("change")
    @$("#txt-cnpj").trigger("change")
    @$("#txt-cpf").trigger("change")
    @$("#txt-email").trigger("change")
    @$("#txt-fone").trigger("change")
    @$("#txt-celular").trigger("change")
    @$("#txt-fax").trigger("change")

    #Considera o CEP inicial valido.
    @set("cepValido", true)

    #Obtem as divs de dados de identificacao de Pessoa Fisica e Pessoa Juridica.
    boxPf = @$("#dados-identificacao-pessoa-fisica")
    boxPj = @$("#dados-identificacao-pessoa-juridica")

    #Mostra a div de PF/PJ conforme o tipo de pessoa.
    if model.get("tipoPessoa").get("tipo") == "PF"
      boxPj.hide()
      boxPf.show()
    else
      boxPf.hide()
      boxPj.show()

    if model.get("sincronizado")
      @$("input").attr("disabled", true)
      @$("select").attr("disabled", true)
      @$(":submit").hide()
      @mostrarMensagem(message: "Esta pessoa foi sincronizada do LIS. Edição desabilitada.", type: "warning", ->)


  submitForm: (callbackOnSubmitComplete) ->

    self = @

    if @get("isEdit")

      metodo   = @atualizarPessoa
      mensagem = "Pessoa atualizada com sucesso! <br> Você será redirecionado em instantes..." 

    else

      metodo   = @cadastrarPessoa
      mensagem = "Pessoa criada com sucesso! <br> Você será redirecionado em instantes..."

    metodo(@, pessoa: @get("model")).then(

      (data) ->

        self.mostrarMensagem(message: mensagem, type: "success",

          ->
            setTimeout(
              ->
                self.sendAction("actionOnSubmitted")
                callbackOnSubmitComplete(true)
              3000
            )

        )

      (errs) ->

        self.mostrarMensagem(message: "Ocorreu um erro.", type: "danger",
          ->
            callbackOnSubmitComplete(false)
        )
    )

  #Carrega os dados de endereco a partir de um CEP.
  carregarDadosEndereco: (endereco = null) ->

    bairro           = ""
    logradouro       = ""
    codIbgeMunicipio = ""
    cidade           = ""

    #Se o endereco foi encontrado pelo cep:
    if endereco != null
      bairro           = endereco["bairro"]
      logradouro       = endereco["logradouro"]
      codIbgeMunicipio = endereco["ibge"]
      cidade           = endereco["localidade"]

    props =
      bairro: bairro
      logradouro: logradouro
      codIbgeMunicipio: codIbgeMunicipio
      cidade: cidade

    #Atribui as informacoes de endereco que foram obtidas pelo CEP.
    @get("model").setProperties(props)

  actions:

    #Mostra a div de informacoes de PF/PJ conforme o tipo de pessoa escolhido.
    actEscolherComboTipoPessoa: (idTipoPessoa) ->

      boxPf = @$("#dados-identificacao-pessoa-fisica")
      boxPj = @$("#dados-identificacao-pessoa-juridica")

      if !idTipoPessoa

        boxPf.hide()
        boxPf.hide()

        @set("tipoValido", false)
        return

      tipoPessoa = @get("store").peekRecord("tipo-pessoa", idTipoPessoa)
      @get("model").set("tipoPessoa", @get("store").peekRecord("tipoPessoa", idTipoPessoa))
      @set("tipoValido", true)

      if tipoPessoa.get("tipo") == "PF"
        boxPj.hide()
        boxPf.show()
      else
        boxPf.hide()
        boxPj.show()

    #Valida o campo Nome.
    actValidarNome: (params, callback) ->
      @set("nomeValido", params["valido"])
      callback()

    #Valida o campo CNPJ.
    actValidarCnpj: (params, callback) ->
      @set("cnpjValido", params["valido"])
      @set("model.cnpj", params["valueSemMascara"])
      callback()

    #Valida o campo CPF.
    actValidarCpf: (params, callback) ->
      @set("cpfValido", params["valido"])
      @set("model.cpf", params["valueSemMascara"])
      callback()

    #Valida o CEP.
    actValidarCep: (params, callback) ->

      @set("model.cep", params["valueSemMascara"])

      valido = false

      if params.hasOwnProperty("endereco")

        if params["endereco"].hasOwnProperty("erro")
          valido = false
        else
          valido = true
      else
        valido = params["valido"]

      @carregarDadosEndereco(params["endereco"])
      @set("cepValido", valido)
      callback()

    #Valida o campo e-mail.
    actValidarEmail: (params, callback) ->
      @set("emailValido", params["valido"])
      callback()

    #Valida o campo telefone.
    actValidarTelefone: (params, callback) ->
      @set("telefoneValido", params["valido"])
      @set("model.telefone", params["valueSemMascara"])
      callback()

    #Valida o campo celular.
    actValidarCelular: (params, callback) ->
      @set("celularValido", params["valido"])
      @set("model.celular", params["valueSemMascara"])
      callback()

    #Valida o campo fax.
    actValidarFax: (params, callback) ->
      @set("faxValido", params["valido"])
      @set("model.fax", params["valueSemMascara"])
      callback()


)

export default FormsNewPessoaComponent
