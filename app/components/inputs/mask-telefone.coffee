import Ember from 'ember'
import InputsGenericMaskComponent from './generic-mask'

InputsMaskTelefoneComponent = InputsGenericMaskComponent.extend(

  type: "tel"

  #Máscara de telefone.
  mascara: "00 0000-00000"

  #Override InputsInputMascaraGenericaComponent
  validarValorMascara: ->
    return @validarTelefoneInterno()

  validarTelefoneInterno: ->
    return @validarTelefone(@obterValorSemMascara())


)

export default InputsMaskTelefoneComponent
