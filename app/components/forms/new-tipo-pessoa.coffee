import Ember from 'ember'
import FormsGenericFormComponent from './generic-form'
import RequestsTipoPessoaMixin from '../../mixins/requests/tipo-pessoa'

FormsNewTipoPessoaComponent = FormsGenericFormComponent.extend(RequestsTipoPessoaMixin,

  isEdit: false

  nomeValido: false
  tipoValido: false

  didReceiveAttrs: () ->
    @_super()
    args = this.get('_args')

    if @get("isEdit")
      @set("nomeValido", true)
      @set("tipoValido", true)

  didInsertElement: ->
    @_super()

    if @get("isEdit")
      @$("select").val(@get("model").get("tipo"))

  #Método de validação do formulário.
  validate: (callbackAfterValidate) ->

    self = @

    arrayErros = []
    valido = true

    if !@get("nomeValido")
      arrayErros.push("O nome deve ser preenchido.")
      valido = false

    if !@get("tipoValido")
      arrayErros.push("O tipo deve ser preenchido.")
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

      metodo   = @atualizarTipoPessoa
      mensagem = "Tipo de pessoa atualizado com sucesso! <br> Você será redirecionado em instantes..."

    else

      metodo   = @cadastrarTipoPessoa
      mensagem = "Tipo de pessoa criado com sucesso! <br> Você será redirecionado em instantes..."

    metodo(@, tipoPessoa: @get("model")).then(

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
      @set("nomeValido", params["valido"])
      callback()

    actAtribuirTipoPessoa: (tipoPessoa) ->
      @set("model.tipo", tipoPessoa)
      @set("tipoValido", if !tipoPessoa then false else true)


)

export default FormsNewTipoPessoaComponent
