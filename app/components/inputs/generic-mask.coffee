import Ember from 'ember'
import InputsGenericInputComponent from './generic-input'

InputsGenericMaskComponent = InputsGenericInputComponent.extend(

  #############################################################################
  #Inicio -Atributos definidos pelo proprio componente.

  #Define o formato da máscara.
  mascara: ""

  #Fim - Atributos definidos pelo proprio componente.
  #############################################################################

  didInsertElement: ->
    @aplicarMascara()
    @_super()

  #Metodo para aplicar a mascara no componente.
  aplicarMascara: ->
    @$().mask(@get("mascara"))

  #Metodo para validar consistencia do valor de acordo com
  #a mascara.
  validarValorMascara: ->
    return true

  #Override da classe mãe InputsInputGenericoComponent
  obterValorInput: ->

    #O valor do input deve ser o valor sem os dados da máscara.
    return @obterValorSemMascara()

  #Metodo para obter o valor do input sem mascara.
  obterValorSemMascara: ->
    @$().cleanVal()

  #Override da classe mãe InputsInputGenericoComponent
  realizarValidacoesAdicionais: (callbackOnValidacaoCompleta) ->

    #Valida a consistência do valor quanto à máscara utilizada.
    if !@validarValorMascara()
      return callbackOnValidacaoCompleta(valido: false)

    #Se o valor está válido em relação à máscara a validação será continuada
    #pelo método da super classe.
    return @_super(callbackOnValidacaoCompleta)

  #Override da classe mãe InputsInputGenericoComponent
  paramsParaValidacaoAssincrona: ->

    #Deve enviar o valor com e sem máscara para a action de validação assíncrona.
    return valueComMascara: @get("value"), valueSemMascara: @obterValorSemMascara()

  #Override da classe mãe InputsInputGenericoComponent
  paramsRetornoFimValidacao: (params) ->
    params                    = @_super(params)
    params["valueSemMascara"] = @obterValorSemMascara()
    return params

)

export default InputsGenericMaskComponent
