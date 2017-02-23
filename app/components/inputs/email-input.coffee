import Ember from 'ember'
import InputsGenericInputComponent from "./generic-input"

InputsEmailInputComponent = InputsGenericInputComponent.extend(

  type: "email"

  realizarValidacoesAdicionais: (callbackOnValidacaoCompleta) ->

    #Se está vazio e o valor vazio é valido:
    if !@get("value") || new String(@get("value")).trim().length == 0 && @get("vazioValido")
      return callbackOnValidacaoCompleta(valido: true)


    if !@validarEmail(@get("value"))
      return callbackOnValidacaoCompleta(valido: false)

    @_super(callbackOnValidacaoCompleta)

)

export default InputsEmailInputComponent
