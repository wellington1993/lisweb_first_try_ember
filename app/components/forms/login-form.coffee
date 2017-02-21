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

    arrayErros = []
    valido = true

    if !@get("emailValido")
      arrayErros.push("O e-mail deve ser preeenchido corretamente.")
      valido = false

    if !@get("senhaValida")
      arrayErros.push("A senha deve ser preenchida corretamente.")
      valido = false

    if valido
      return callbackAfterValidate(valido)

    @mostrarMensagem(message: arrayErros, type: "danger",
      ->
        return callbackAfterValidate(valido)
    )

  #Método de submit do form após a validação bem sucedida.
  submitForm: ->
    @fazerLogin()

  fazerLogin: ->

    self = @

    dadosAcesso = @getProperties("email", "senha")

    @get("applicationSession").login(email: dadosAcesso["email"], password: dadosAcesso["senha"],
      (success, data) ->
    )

  actions:

    actValidarCampoEmail: (params, callbackAposRetornoValidacao = ->) ->
      @set("emailValido", params["valido"])

    actValidarCampoSenha: (params, callbackAposRetornoValidacao = ->) ->
      @set("senhaValida", params["valido"])

)

export default FormsLoginFormComponent
