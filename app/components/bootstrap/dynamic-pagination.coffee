import Ember from 'ember'
import UtilsMixin from '../../mixins/utils'

BootstrapDynamicPaginationComponent = Ember.Component.extend(UtilsMixin,

  tagName: "ul"

  actionOnClick: null
  mostrarProximoAnterior: true
  totalPaginas: null
  paginaAtual: null
  labelBtnAnterior: "Anterior"
  labelBtnProximo: "Próximo"
  mostrarBotaoUltimo: true

  totalPaginasArray: Ember.computed("totalPaginas", ->
    return @intForArray(@get("totalPaginas"))
  )

  paginasVisiveis: Ember.computed("totalPaginasArray.length", ->

    totalPaginasArray = @get("totalPaginasArray")

    if totalPaginasArray.get("length") > 10
      return @intForArray(10)

    return totalPaginasArray

  )

  didReceiveAttrs: () ->
    @atualizarEstadoPaginador()
    @_super(args)
    args = this.get('_args')

  didInsertElement: ->
    @atualizarEstadoPaginador()

  atualizarEstadoPaginador: ->

    if !@$()
      return

    @indicarPaginaAtual()
    @habilitarDesabilitarBotoesProximoAnterior()

  indicarPaginaAtual: ->
    paginaAtual = @get("paginaAtual")
    @$(".active").removeClass("active")

    botaoPaginaAtual = @$(".li-pg-#{paginaAtual}")

    if botaoPaginaAtual.length == 0
      setTimeout(
        ->
          botaoPaginaAtual = @$(".li-pg-#{paginaAtual}")
          botaoPaginaAtual.addClass("active")
        1
      )
    else
      botaoPaginaAtual.addClass("active")

  habilitarDesabilitarBotoesProximoAnterior: ->

    if !@get("mostrarProximoAnterior")
      return

    paginaAtual  = parseInt(@get("paginaAtual"))
    totalPaginas = parseInt(@get("totalPaginas"))
    liProx       = @$(".li-pg-prox")
    liAnt        = @$(".li-pg-ant")


    if paginaAtual == 1
      liAnt.addClass("disabled")
    else
      liAnt.removeClass("disabled")

    if paginaAtual == totalPaginas
      liProx.addClass("disabled")
    else
      liProx.removeClass("disabled")

  cliquePaginador: (numeroPagina) ->

    self = @

    paginaAtual  = parseInt(@get("paginaAtual"))
    totalPaginas = parseInt(@get("totalPaginas"))

    if numeroPagina == paginaAtual || numeroPagina > totalPaginas || numeroPagina < 1
      return

    @sendAction("actionOnClick", numeroPagina,

      callbackSucessoMudancaPagina = (sucessoMudancaPagina) ->

        if sucessoMudancaPagina
          self.set("paginaAtual", numeroPagina)
          self.atualizarEstadoPaginador()

    )

  actions:

    actCliqueBotaoNumerico: (numeroPagina) ->
      @cliquePaginador(numeroPagina)

    actCliqueBotaoAnterior: ->
      @cliquePaginador(parseInt(@get("paginaAtual")) - 1)

    actCliqueBotaoProximo: ->
      @cliquePaginador(parseInt(@get("paginaAtual")) + 1)

    actCliqueBotaoUltima: ->
      @cliquePaginador(@get("totalPaginasArray").get("length"))

)

export default BootstrapDynamicPaginationComponent
