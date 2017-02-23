import Ember from 'ember'
import FormsGenericFormComponent from './generic-form'

FormsNewPessoaContatoComponent = FormsGenericFormComponent.extend(

  emailValido: false
  telefoneValido: false
  celularValido: false
  faxValido: false

  telefone: null
  celular: null
  fax: null

  didReceiveAttrs: (args) ->
    @_super(args)

    if @get("isEdit")
      @set("telefone", @get("model.telefone"))
      @set("celular", @get("model.celular"))
      @set("fax", @get("model.fax"))

  didInsertElement: ->
    @_super()

    if @get("isEdit")
      @inicializarModoEdicao()

  inicializarModoEdicao: ->
    @$("#txt-email").trigger("change")
    @$("#txt-fone").trigger("change")
    @$("#txt-celular").trigger("change")
    @$("#txt-fax").trigger("change")

  actions:

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

export default FormsNewPessoaContatoComponent
