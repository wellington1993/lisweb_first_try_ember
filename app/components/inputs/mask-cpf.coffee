import Ember from 'ember'
import InputsGenericMaskComponent from './generic-mask'

InputsMaskCpfComponent = InputsGenericMaskComponent.extend(

  #Mascara de CPF
  mascara: "000.000.000-00"

  #Override InputsInputMascaraGenericaComponent
  validarValorMascara: ->
    return @validarCpfInterno()

  validarCpfInterno: ->
    return @validarCPF(@obterValorSemMascara())

)

export default InputsMaskCpfComponent
