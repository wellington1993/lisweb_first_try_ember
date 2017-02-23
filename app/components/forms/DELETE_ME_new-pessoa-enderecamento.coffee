import Ember from 'ember'
import FormsGenericFormComponent from './generic-form'

FormsNewPessoaEnderecamentoComponent = FormsGenericFormComponent.extend(

  cep: null
  cepValido: false

  didReceiveAttrs: (args) ->
    @_super(args)

    if @get("isEdit")
      @set("cep", @get("model.cep"))

  didInsertElement: ->
    @_super()

    if @get("isEdit")
      @inicializarModoEdicao()

  inicializarModoEdicao: ->
    @set("cepValido", true)

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



)

export default FormsNewPessoaEnderecamentoComponent
