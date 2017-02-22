import Ember from 'ember'

UtilsComponentsDivTransitionMixin = Ember.Mixin.create(

  utilizarAnimacaoNaTransicao: true

  arrayEtapasDiv: null

  divAtual: null

  divLoading: null

  divAnterior: Ember.computed("arrayEtapasDiv", "divAtual", ->

    arrayEtapas = @get("arrayEtapasDiv")

    if !arrayEtapas || arrayEtapas.length < 2
      return null

    divAtual = @get("divAtual")

    if !divAtual
      return null

    indexEtapaAtual = arrayEtapas.indexOf(divAtual)

    if indexEtapaAtual == 0
      return null

    return arrayEtapas[(indexEtapaAtual-1)]

  )

  proximaDiv: Ember.computed("arrayEtapasDiv", "divAtual", ->

    arrayEtapas = @get("arrayEtapasDiv")

    if !arrayEtapas || arrayEtapas.length == 0
      return null

    divAtual = @get("divAtual")

    if !divAtual
      return @get(arrayEtapas[0])

    indexEtapaAtual = arrayEtapas.indexOf(divAtual)

    if indexEtapaAtual == (arrayEtapas.length - 1)
      return null

    return arrayEtapas[(indexEtapaAtual+1)]

  )

  mapearDivsAtributos: ->
    #Quem utilizar o mixin deve implementar no didInsertElement...
    #Ex: @set("div1", @$("#div1"))
    #    @set("div2", @$("#div2"))

  inicializarEstadoDivs: ->
    #Quem utilizar o mixin deve implementar no didInsertElement...
    #Ex: @get("div1").show()
    #    @get("div1").hide()...

  determinarArrayEtapasDiv: ->
    #Quem utilizar o mixin deve implementar no didInsertElement...
    #Ex: @set("determinarArrayEtapasDiv", [@get("div1"), @get("div2")...])

  alternarJanela: (params, callbackOnAnimationComplete = ->) ->

    self = @

    divAtual = @get("divAtual")

    if divAtual == params["proximaDiv"]

      if !divAtual.is(":visible")
        divAtual.show()

      return callbackOnAnimationComplete()

    utilizarAnimacaoNaTransicao = @get("utilizarAnimacaoNaTransicao")

    if utilizarAnimacaoNaTransicao

      if divAtual
        divAtual.fadeOut("fast",
          ->
            params["proximaDiv"].fadeIn("fast",
              ->

                try
                  self.set("divAtual", params["proximaDiv"])
                catch e

                callbackOnAnimationComplete()
            )
        )
      else
        params["proximaDiv"].fadeIn("fast",
          ->

            try
              self.set("divAtual", params["proximaDiv"])
            catch e

            callbackOnAnimationComplete()
        )

    else
      if divAtual
        divAtual.hide()
      params["proximaDiv"].show()
      @set("divAtual", params["proximaDiv"])
      callbackOnAnimationComplete()

  alternarParaProximaDiv: (params, callbackOnAnimationComplete = ->) ->

    proximaDiv = @get("proximaDiv")

    params["proximaDiv"] = proximaDiv

    if proximaDiv
      @alternarJanela(params, callbackOnAnimationComplete)

  alternarParaDivAnterior: (params, callbackOnAnimationComplete = ->) ->

    divAnterior = @get("divAnterior")

    params["proximaDiv"] = divAnterior

    if divAnterior
      @alternarJanela(params, callbackOnAnimationComplete)

  mostrarLoading: (params, callbackOnAnimationComplete = ->) ->
    @alternarJanela(proximaDiv: @get("divLoading"), callbackOnAnimationComplete)

)

export default UtilsComponentsDivTransitionMixin
