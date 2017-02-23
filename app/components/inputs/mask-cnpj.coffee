import Ember from 'ember'
import InputsGenericMaskComponent from './generic-mask'

InputsMaskCnpjComponent = InputsGenericMaskComponent.extend(

  #Máscara de CNPJ
  mascara: "00.000.000/0000-00"

  #Override InputsInputMascaraGenericaComponent.
  validarValorMascara: ->
    return @validarCnpjInterno()

  validarCnpjInterno: ->
    return @validarCNPJ(@obterValorSemMascara())

)

export default InputsMaskCnpjComponent
