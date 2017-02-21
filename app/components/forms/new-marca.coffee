import Ember from 'ember'
import FormsGenericFormComponent from './generic-form'
import RequestsMarcaMixin from '../../mixins/requests/marca'

FormsNewMarcaComponent = FormsGenericFormComponent.extend(RequestsMarcaMixin,

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

    store = @get("store")

    marca = store.createRecord("marca", nome: @get("nome"), descricao: @get("descricao"))

    @cadastrarMarca(@, marca: marca).then(

      (marca) ->

        self.mostrarMensagem(message: "Marca cadastrada com sucesso! <br> Você será redirecionado em instantes...", type: "success",

          ->
            setTimeout(
              ->
                self.sendAction("actionOnSubmitted")
                callbackOnSubmitComplete()
              3000
            )

        )

      (errors) ->
        self.mostrarMensagem(message: "Ocorreu um erro ao tentar criar nova marca.", type: "danger",
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

export default FormsNewMarcaComponent
