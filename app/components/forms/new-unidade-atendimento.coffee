import Ember from 'ember'
import FormsGenericFormComponent from './generic-form'
import RequestsUnidadeAtendimentoMixin from '../../mixins/requests/unidade-atendimento'

FormsNewUnidadeAtendimentoComponent = FormsGenericFormComponent.extend(RequestsUnidadeAtendimentoMixin,

  isEdit: false

  nomeValido: false

  didReceiveAttrs: () ->
    @_super()
    args = this.get('_args')

    if @get("isEdit")
      @set("nomeValido", true)

  #Método de validação do formulário.
  validate: (callbackAfterValidate) ->

    self = @

    arrayErros = []
    valido = true

    if !@get("nomeValido")
      arrayErros.push("O nome deve ser preenchido.")
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

      metodo   = @atualizarUnidadeAtendimento
      mensagem = "Unidade de atendimento atualizada com sucesso! <br> Você será redirecionado em instantes..."

    else

      metodo   = @cadastrarUnidadeAtendimento
      mensagem = "Unidade de atendimento criada com sucesso! <br> Você será redirecionado em instantes..."

    metodo(@, unidadeAtendimento: @get("model")).then(

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


)

export default FormsNewUnidadeAtendimentoComponent
