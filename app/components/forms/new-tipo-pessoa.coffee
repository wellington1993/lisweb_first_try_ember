import Ember from 'ember'
import FormsGenericFormComponent from './generic-form'
import RequestsTipoPessoaMixin from '../../mixins/requests/tipo-pessoa'

FormsNewTipoPessoaComponent = FormsGenericFormComponent.extend(RequestsTipoPessoaMixin,

  nome: null
  tipo: null

  nomeValido: false
  tipoValido: false

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

    options = {}
    options["attrs"] = nome: @get("nome"), tipo: @get("tipo")

    @cadastrarTipoPessoa(@, options).then(

      (marca) ->

        self.mostrarMensagem(message: "Tipo cadastrado com sucesso! <br> Você será redirecionado em instantes...", type: "success",

          ->
            setTimeout(
              ->
                self.sendAction("actionOnSubmitted")
                callbackOnSubmitComplete()
              3000
            )

        )

      (errors) ->
        self.mostrarMensagem(message: "Ocorreu um erro ao tentar criar novo tipo.", type: "danger",
          ->
            callbackOnSubmitComplete()
        )


    )

  actions:

    actValidarNome: (params, callback) ->
      @set("nomeValido", params["valido"])
      callback()

    actAtribuirTipoPessoa: (tipoPessoa) ->
      @set("tipo", tipoPessoa)
      @set("tipoValido", if !tipoPessoa then false else true)


)

export default FormsNewTipoPessoaComponent
