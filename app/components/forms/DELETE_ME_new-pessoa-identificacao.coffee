import Ember from 'ember'
import FormsGenericFormComponent from './generic-form'

FormsNewPessoaIdentificacaoComponent = FormsGenericFormComponent.extend(

  store: Ember.inject.service()

  tiposPessoa: null

  cnpj: null
  cpf: null

  tipoValido: false
  nomeValido: false
  cnpjValido: false
  cpfValido: false

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

  didInsertElement: ->
    @_super()

    if @get("isEdit")
      @inicializarModoEdicao()

  inicializarModoEdicao: ->

    model = @get("model")

    @$("#cmb-tipo-pessoa").val(model.get("tipoPessoa").get("id"))
    @$("#cmb-tipo-pessoa").trigger("change")

    @$("#txt-nome-pj").trigger("change")
    @$("#txt-cnpj").trigger("change")
    @$("#txt-cpf").trigger("change")

    boxPf = @$("#dados-identificacao-pessoa-fisica")
    boxPj = @$("#dados-identificacao-pessoa-juridica")

    if model.get("tipoPessoa").get("tipo") == "PF"
      boxPj.hide()
      boxPf.show()
    else
      boxPf.hide()
      boxPj.show()

  submitForm: (callbackOnSubmitComplete) ->

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

    actShowDirty: ->
      console.log(@get("model").changedAttributes())

)

export default FormsNewPessoaIdentificacaoComponent
