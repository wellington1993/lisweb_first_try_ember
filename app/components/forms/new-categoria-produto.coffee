import Ember from 'ember'
import FormsGenericFormComponent from './generic-form'
import RequestsCategoriaProdutoMixin from '../../mixins/requests/categoria-produto'

FormsNewCategoriaProdutoComponent = FormsGenericFormComponent.extend(RequestsCategoriaProdutoMixin,

  nome: null
  descricao: null

  nomeValido: false
  descricaoValida: false

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

    options           = {}
    options["attrs"]  = nome: @get("nome"), descricao: @get("descricao")

    @cadastrarCategoriaProduto(@, options).then(

      (marca) ->

        self.mostrarMensagem(message: "Categoria de produto cadastrada com sucesso! <br> Você será redirecionado em instantes...", type: "success",

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

)

export default FormsNewCategoriaProdutoComponent
