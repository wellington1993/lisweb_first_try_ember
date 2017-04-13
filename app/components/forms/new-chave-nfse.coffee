import Ember from 'ember'
import FormsGenericFormComponent from './generic-form'
import RequestsChaveNfseMixin from '../../mixins/requests/chave-nfse'

FormsNewChaveNfseComponent = FormsGenericFormComponent.extend(RequestsChaveNfseMixin,

  isEdit: false

  chaveValida: false
  valorValido: false

  didReceiveAttrs: (args) ->
    @_super()

    if @get("isEdit")
      @set("chaveValida", true)
      @set("valorValido", true)

  #Método de validação do formulário.
  validate: (callbackAfterValidate) ->

    self = @

    arrayErros = []
    valido = true

    if !@get("chaveValida")
      arrayErros.push("A chave deve ser preenchida.")
      valido = false

    if !@get("valorValido")
      arrayErros.push("O valor deve ser preenchido.")
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

      metodo   = @atualizarChaveNfse
      mensagem = "Chave Nfse atualizada com sucesso! <br> Você será redirecionado em instantes..."

    else

      metodo   = @cadastrarChaveNfse
      mensagem = "Chave Nfse criada com sucesso! <br> Você será redirecionado em instantes..."

    metodo(@, chaveNfse: @get("model")).then(

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

    actValidarChave: (params, callback) ->
      callback()
      @set("chaveValida", params["valido"])

    actValidarValor: (params, callback) ->
      callback()
      @set("valorValido", params["valido"])

)

export default FormsNewChaveNfseComponent
