import Ember from 'ember'
import UtilsComponentsInputMixin from '../../mixins/utils/components/input'
import UtilsMixin from '../../mixins/utils'

#Este é o componente principal para todos os input-texts da aplicação.
#Os novos componentes devem herdar deste ou de classes filhas deste componente.

InputsGenericInputComponent = Ember.TextField.extend(UtilsComponentsInputMixin, UtilsMixin, 

  #############################################################################
  #Inicio - Atributos definidos pelo contexto externo.

  #Indica se quando o campo está vazio é considerado válido ou não.
  vazioValido: false

  #(params, callbackAposRetornoValidacao[{}])
  actionOnFimValidacao: null

  #(null)
  actionOnIniciarValidacaoAssincrona: null

  #(null)
  actionOnFinalizarValidacaoAssincrona: null

  #({}, callbackOnValidacaoFinalizada[params])
  actionOnRealizarValidacaoAssincrona: null

  #Fim - Atributos definidos pelo contexto externo.
  #############################################################################


  #############################################################################
  #Inicio - Atributos definidos pelo proprio componente.

  #Atribui a classe fixa do bootstrap.
  classNames: ["form-control"]

  #Atributo opcional para determinar o length mínimo.
  lengthMinimo: null

  #Método para realizar validações adicionais assíncronas internas do componente.
  #(context, {}, callbackOnValidacaoFinalizada[callback])
  metodoAssincronoValidacaoInterna: null

  #Flag indicadora se o componente possui método assíncrono de validação.
  possuiMetodoAssincronoValidacaoInterna: Ember.computed("metodoAssincronoValidacaoInterna", ->

    if !@get("metodoAssincronoValidacaoInterna")
      return false

    return true

  )

  #Indica se o tamanho mínimo deve ser válidado.
  validarLengthMinimo: Ember.computed("lengthMinimo", ->

    if !@get("lengthMinimo")
      return false

    return true

  )

  #Indica se será realizada validação assíncrona após a validação default do
  #componente.
  validarAssincronamente: Ember.computed("actionOnRealizarValidacaoAssincrona", ->

      if !@get("actionOnRealizarValidacaoAssincrona")
        return false

      return true

  )

  #Fim - Atributos definidos pelo proprio componente.
  #############################################################################

  #Override do evento change do input-field
  change: ->

    #Importante: se o contexto externo atribuir o valor do input por $().val() ou
    #alterar o valor da variavel vinculada ao binding diretamente o evento change
    #não é disparado. Nessa situacao é necessario alterar diretamente a flag
    #de validacao do contexto externo caso queira invalidar o campo.

    self = @

    #Chama o método principal de validação do campo.
    @validarCampo(

      (params) ->

        #Notifica o contexto externo sobre o resultado da validação.
        self.sendAction("actionOnFimValidacao", params,

          callbackAposRetornoValidacao = (args = {}) ->
            #Até o momento não é necessário fazer nada.

        )

    )

  #Método principal para realizar a validação do campo.
  validarCampo: (callbackResultadoValidacao = ->) ->

    #Valida o tamanho do campo.
    if !@validarTamanhoCampo()
      return callbackResultadoValidacao(valido: false)

    #Realiza as validações adicionais:
    @realizarValidacoesAdicionais(

      (params) ->
        return callbackResultadoValidacao(params)

    )

  #Método para fazer as validações adicionais. Para classes filhas é recomendável
  #que este método seja sobreescrito para realizar validações específicas.
  realizarValidacoesAdicionais: (callbackOnValidacaoCompleta) ->

    #Início - finalizarValidacao

    #Método interno para finalizar a validação adicional.
    finalizarValidacao = (context) ->

      #Se não foi atribuída nenhuma action para validação assíncrona:
      if !context.get("validarAssincronamente")
        return callbackOnValidacaoCompleta(valido: true)

      #Indica ao contexto externo de que uma validação assíncrona irá se iniciar.
      context.sendAction("actionOnIniciarValidacaoAssincrona")

      #Chama a action da validação assíncrona.
      context.sendAction("actionOnRealizarValidacaoAssincrona", context.paramsParaValidacaoAssincrona(),

        (params) ->

          #Notifica o contexto externo de que a validação assíncrona terminou.
          context.sendAction("actionOnFinalizarValidacaoAssincrona")

          #Determina os parâmetros a serem enviados para o callback de fim da
          #validação.
          params = context.paramsRetornoFimValidacao(params)

          return callbackOnValidacaoCompleta(params)

      )

    #Fim - finalizarValidacao

    self = @

    #Se existe algum método de validação assíncrona interna:
    if @get("possuiMetodoAssincronoValidacaoInterna")

      #Indica ao contexto externo de que uma validação assíncrona irá se iniciar.
      @sendAction("actionOnIniciarValidacaoAssincrona")

      @get("metodoAssincronoValidacaoInterna")(@, {},

        (params, callbackOnComplete)->

          #Notifica o contexto externo de que a validação assíncrona terminou.
          self.sendAction("actionOnFinalizarValidacaoAssincrona")

          callbackOnComplete()

          #Se o método assíncrono interno validou com sucesso:
          if params["valido"]

            #Continua o fluxo das validações.
            return finalizarValidacao(self)

          #Caso o método assíncrono não tenha retornado válido:
          return callbackOnValidacaoCompleta(params)

      )

    else

      #Continua o fluxo da validação.
      return finalizarValidacao(self)

  #Método para determinar os parâmetros que serão enviados para a action de
  #validação assíncrona
  #É recomendável que as classes filhas sobreescrevam este método para manipular
  #os parâmetros específicos para cada validação.
  paramsParaValidacaoAssincrona: ->
    return value: @get("value")

  #Determina quais valores serão enviados ao fim da validação.
  paramsRetornoFimValidacao: (params) ->
    params["value"] = @get("value")
    return params

  #Metodo para validar o tamanho do campo.
  validarTamanhoCampo: ->

    #Obtém os atributos do componente.
    value               = @obterValorInput()
    vazioValido         = @get("vazioValido")
    validarLengthMinimo = @get("validarLengthMinimo")
    lengthMinimo        = @get("lengthMinimo")

    #Se o campo não foi atribuído (null ou undefined) e não é permitido campo
    #vazio:
    if !value && !vazioValido
      return false

    #Converte o valor do input para String.
    campoString = new String(value)

    #Se o tipo do input é password o length deve ser calculado desconsiderando
    #a função trim().
    if @get("type") == "password"
      length = campoString.length
    else
      length = campoString.trim().length

    #Se o campo vazio é inválido e o input está com valor em branco:
    if !vazioValido && length == 0
      return false

    #Se é necessário validar o length mínimo, verifica se o length do valor
    #do input é maior ou igual o length mínimo requisitado.
    if validarLengthMinimo && length < parseInt(lengthMinimo)
      return false

    return true

  #Método para obter o valor do input.
  #Este método pode ser sobreescrito pelas classes filhas. Dependendo do tipo
  #do add-on utilizado no input o valor real do componente pode não estar
  #disponível no atributo "value".
  #EX: máscaras tem o atributo "value" com a os dados da máscara inclusos.
  obterValorInput: ->
    return @get("value")

)

export default InputsGenericInputComponent
