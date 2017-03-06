import Ember from 'ember'
import FormsGenericFormComponent from './generic-form'
import RequestsMarcaMixin from '../../mixins/requests/marca'

FormsNewMarcaComponent = FormsGenericFormComponent.extend(RequestsMarcaMixin,

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

      metodo   = @atualizarMarca
      mensagem = "Marca atualizada com sucesso! <br> Você será redirecionado em instantes..."

    else

      metodo   = @cadastrarMarca
      mensagem = "Marca criada com sucesso! <br> Você será redirecionado em instantes..."

    metodo(@, marca: @get("model")).then(

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

export default FormsNewMarcaComponent
