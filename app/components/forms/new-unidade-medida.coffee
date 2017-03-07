import Ember from 'ember'
import FormsGenericFormComponent from './generic-form'
import RequestsUnidadeMedidaMixin from '../../mixins/requests/unidade-medida'

FormsNewUnidadeMedidaComponent = FormsGenericFormComponent.extend(RequestsUnidadeMedidaMixin,


  isEdit: false

  nomeValido: false
  descricaoValida: false
  siglaValida: false

  didReceiveAttrs: (args) ->
    @_super()

    if @get("isEdit")
      @set("nomeValido", true)
      @set("descricaoValida", true)
      @set("siglaValida", true)

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

    if @get("isEdit")

      metodo   = @atualizarUnidadeMedida
      mensagem = "Unidade de medida atualizada com sucesso! <br> Você será redirecionado em instantes..."

    else

      metodo   = @cadastrarUnidadeMedida
      mensagem = "Unidade de medida criada com sucesso! <br> Você será redirecionado em instantes..."

    metodo(@, unidadeMedida: @get("model")).then(

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
