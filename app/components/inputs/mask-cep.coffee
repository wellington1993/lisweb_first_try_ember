import Ember from 'ember'
import InputsGenericMaskComponent from './generic-mask'
import RequestsEnderecoMixin from '../../mixins/requests/endereco'

InputsMaskCepComponent = InputsGenericMaskComponent.extend(RequestsEnderecoMixin,

  request: Ember.inject.service()

  #Mascara de CEP
  mascara: "00000-000"

  #Objeto que possui o endereço obtido após a validação AJAX do CEP.
  enderecoCep: null

  #Override InputsInputMascaraGenericaComponent
  validarValorMascara: ->
    return @validarCepInterno()

  #Método para validar se o cep é tecnicamente válido (não verifica se o CEP
  #é existente).
  validarCepInterno: ->
    return @validarCEP(@obterValorSemMascara())

  #Override InputsInputGenericoComponent
  metodoAssincronoValidacaoInterna: (context, params, callbackOnComplete) ->
    return context.validarCepWebservice(params, callbackOnComplete)

  #Método para validar o CEP no Webservice.
  validarCepWebservice: (params, callbackOnComplete) ->

    self = @

    #Obtém o valor do CEP.
    cep = @obterValorSemMascara()

    #Faz requisição para validar o CEP.
    @get("request").makeRequest(@, @obterEnderecoPorCep, cep: cep,

      (sucesso, dados, httpCode) ->

        #Realiza o tratamento do callback conforme o resultado da validação.
        if !sucesso
          return callbackOnComplete(valido: false, ->)

        #Armazena o endereço vinculado ao CEP.
        self.set("enderecoCep", dados)

        #Indica que os dados são válidos.
        dados["valido"] = sucesso

        return callbackOnComplete(dados, ->)

    )

  #Override da classe mãe InputsInputMascaraGenericaComponent
  paramsRetornoFimValidacao: (params) ->
    params             = @_super(params)

    #Se a validação foi executada com sucesso os parâmetros de retorno
    #devem devolver o endereço vinculado ao CEP.
    if params["valido"]
      params["endereco"] = @get("enderecoCep")

    return params

)

export default InputsMaskCepComponent
