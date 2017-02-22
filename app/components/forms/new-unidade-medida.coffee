import Ember from 'ember'
import FormsGenericFormComponent from './generic-form'
import RequestsUnidadeMedidaMixin from '../../mixins/requests/unidade-medida'

FormsNewUnidadeMedidaComponent = FormsGenericFormComponent.extend(RequestsUnidadeMedidaMixin,

  nome: null
  descricao: null
  sigla: null

  nomeValido: false
  descricaoValida: false
  siglaValida: false

  #Método de validação do formulário.
  validate: (callbackAfterValidate) ->

    self = @

    arrayErros = []
    valido = true

    if !@get("nomeValido")
      arrayErros.push("O nome deve ser preenchido.")
      valido = false

    if !@get("descricaoValida")
      arrayErros.push("A descrição deve ser preenchida.")
      valido = false

    if !@get("siglaValida")
      arrayErros.push("A sigla deve ser preenchida.")
      valido = false

    if valido
      return @esconderMensagem({},
        ->
          callbackAfterValidate(valido)
      )

    @mostrarMensagem(message: arrayErros, type: "danger",
      ->
        return callbackAfterValidate(valido)
    )

  submitForm: (callbackOnSubmitComplete) ->

    self = @

    options           = {}
    options["attrs"]  = nome: @get("nome"), descricao: @get("descricao"), sigla: @get("sigla")

    @cadastrarUnidadeMedida(@, options).then(

      (marca) ->

        self.mostrarMensagem(message: "Unidade de medida cadastrada com sucesso! <br> Você será redirecionado em instantes...", type: "success",

          ->
            setTimeout(
              ->
                self.sendAction("actionOnSubmitted")
                callbackOnSubmitComplete()
              3000
            )

        )

      (errors) ->
        self.mostrarMensagem(message: "Ocorreu um erro.", type: "danger",
          ->
            callbackOnSubmitComplete()
        )


    )


  actions:

    actValidarNome: (params, callback) ->
      callback()
      @set("nomeValido", params["valido"])

    actValidarDescricao: (params, callback) ->
      callback()
      @set("descricaoValida", params["valido"])

    actValidarSigla: (params, callback) ->
      callback()
      @set("siglaValida", params["valido"])


)

export default FormsNewUnidadeMedidaComponent
