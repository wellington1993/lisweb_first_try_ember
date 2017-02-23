import Ember from 'ember'

FormsNewPessoaComponent = Ember.Component.extend(


  store: Ember.inject.service()

  tiposPessoa: null

  cnpj: null
  cpf: null
  telefone: null
  celular: null
  fax: null
  cep: null

  tipoValido: false
  nomeValido: false
  cnpjValido: false
  cpfValido: false
  cepValido: false
  emailValido: false
  telefoneValido: false
  celularValido: false
  faxValido: false

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

    if @get("isEdit")
      @set("cnpj", @get("model.cnpj"))
      @set("cpf", @get("model.cpf"))
      @set("cep", @get("model.cep"))
      @set("telefone", @get("model.telefone"))
      @set("celular", @get("model.celular"))
      @set("fax", @get("model.fax"))

  didInsertElement: ->
    @_super()

    if @get("isEdit")
      @inicializarModoEdicao()

  inicializarModoEdicao: ->

    @set("cepValido", true)

    model = @get("model")

    @$("#cmb-tipo-pessoa").val(model.get("tipoPessoa").get("id"))
    @$("#cmb-tipo-pessoa").trigger("change")

    @$("#txt-nome-pj").trigger("change")
    @$("#txt-cnpj").trigger("change")
    @$("#txt-cpf").trigger("change")

    @$("#txt-email").trigger("change")
    @$("#txt-fone").trigger("change")
    @$("#txt-celular").trigger("change")
    @$("#txt-fax").trigger("change")

    boxPf = @$("#dados-identificacao-pessoa-fisica")
    boxPj = @$("#dados-identificacao-pessoa-juridica")

    if model.get("tipoPessoa").get("tipo") == "PF"
      boxPj.hide()
      boxPf.show()
    else
      boxPf.hide()
      boxPj.show()

  submitForm: (callbackOnSubmitComplete) ->

  carregarDadosEndereco: (endereco = null) ->

    bairro           = ""
    logradouro       = ""
    codIbgeMunicipio = ""
    cidade           = ""

    if endereco != null
      bairro = endereco["bairro"]
      logradouro = endereco["logradouro"]
      codIbgeMunicipio = endereco["ibge"]
      cidade = endereco["localidade"]

    props =
      bairro: bairro
      logradouro: logradouro
      codIbgeMunicipio: codIbgeMunicipio
      cidade: cidade

    @get("model").setProperties(props)

  actions:

    actEscolherComboTipoPessoa: (idTipoPessoa) ->

      if !idTipoPessoa
        @set("tipoValido", false)
        return

      @set("tipoValido", true)
      @get("model").set("tipoPessoa", @get("store").peekRecord("tipoPessoa", idTipoPessoa))

      tipoPessoa = @get("store").peekRecord("tipo-pessoa", idTipoPessoa)

      boxPf = @$("#dados-identificacao-pessoa-fisica")
      boxPj = @$("#dados-identificacao-pessoa-juridica")

      if tipoPessoa.get("tipo") == "PF"
        boxPj.hide()
        boxPf.show()
      else
        boxPf.hide()
        boxPj.show()

    actValidarNome: (params, callback) ->
      @set("nomeValido", params["valido"])
      callback()

    actValidarCnpj: (params, callback) ->
      @set("cnpjValido", params["valido"])
      @set("model.cnpj", params["valueSemMascara"])
      callback()

    actValidarCpf: (params, callback) ->
      @set("cpfValido", params["valido"])
      @set("model.cpf", params["valueSemMascara"])
      callback()

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


    actValidarEmail: (params, callback) ->
      @set("emailValido", params["valido"])
      callback()

    actValidarTelefone: (params, callback) ->
      @set("telefoneValido", params["valido"])
      @set("model.telefone", params["valueSemMascara"])
      callback()

    actValidarCelular: (params, callback) ->
      @set("celularValido", params["valido"])
      @set("model.celular", params["valueSemMascara"])
      callback()

    actValidarFax: (params, callback) ->
      @set("faxValido", params["valido"])
      @set("model.fax", params["valueSemMascara"])
      callback()


)

export default FormsNewPessoaComponent
