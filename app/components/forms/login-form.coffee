import Ember from 'ember'
import FormsGenericFormComponent from './generic-form'

FormsLoginFormComponent = FormsGenericFormComponent.extend(

  applicationSession: Ember.inject.service()

  #Atributos que fazem binding com os componentes HTML.
  email: null
  senha: null

  #Flags de validação de cada input.
  emailValido: false
  senhaValida: false

  #Método de validação do formulário.
  validate: (callbackAfterValidate) ->

    valido = false

    if @get("emailValido") && @get("senhaValida")
      valido = true
    console.log(valido)
    return callbackAfterValidate(valido)

  #Método de submit do form após a validação bem sucedida.
  submitForm: ->
    @fazerLogin()

  fazerLogin: ->

    self = @

    dadosAcesso = @getProperties("email", "senha")

    @get("applicationSession").login(email: dadosAcesso["email"], password: dadosAcesso["senha"],

      (success, data) ->
        console.log(success)
    )

  actions:

    actValidarCampoEmail: (params, callbackAposRetornoValidacao = ->) ->
      @set("emailValido", params["valido"])

    actValidarCampoSenha: (params, callbackAposRetornoValidacao = ->) ->
      @set("senhaValida", params["valido"])

)

export default FormsLoginFormComponent
