import Ember from 'ember'
import FormsGenericFormComponent from './generic-form'
import RequestsCategoriaProdutoMixin from '../../mixins/requests/categoria-produto'

FormsNewCategoriaProdutoComponent = FormsGenericFormComponent.extend(RequestsCategoriaProdutoMixin,

  isEdit: false

  nomeValido: false
  descricaoValida: false

  didReceiveAttrs: (args) ->
    @_super()

    if @get("isEdit")
      @set("nomeValido", true)
      @set("descricaoValida", true)

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

      metodo   = @atualizarCategoriaProduto
      mensagem = "Categoria de produto atualizada com sucesso! <br> Você será redirecionado em instantes..."

    else

      metodo   = @cadastrarCategoriaProduto
      mensagem = "Categoria de produto criada com sucesso! <br> Você será redirecionado em instantes..."

    metodo(@, categoriaProduto: @get("model")).then(

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

)

export default FormsNewCategoriaProdutoComponent
