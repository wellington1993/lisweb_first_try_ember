import Ember from 'ember'
import BootstrapModalsGenericModalComponent from './generic-modal'

BootstrapModalsEscolhaLaboratorioComponent = BootstrapModalsGenericModalComponent.extend(

  applicationSession: Ember.inject.service()

  #Atributo proveniente do contexto externo.
  laboratorio: null

  #Atributos para armazenar seletores jQuery.
  janelaSpinner: null
  janelaErro: null
  janelaSucesso: null

  didInsertElement: ->
    @configurarModal()
    @mapearDivsAtributos()
    @inicializarEstadoDivs()

  configurarModal: ->

    self = @

    @$(".modal").on("hidden.bs.modal",
      ->
        self.inicializarEstadoDivs()
    )

    @$(".modal").on("shown.bs.modal",
      ->
        self.escolherLaboratorioInterno()
    )

  #Faz requisição para escolher o laboratório.
  escolherLaboratorioInterno: ->

    self = @

    @get("applicationSession").escolherLaboratorioUsuario(@get("laboratorio"),

      (isSucesso, dados, httpCode) ->

        if isSucesso
          proximaDiv = self.get("janelaSucesso")
        else
          proximaDiv = self.get("janelaErro")

        self.alternarJanela(proximaDiv: proximaDiv)

    )

  mapearDivsAtributos: ->
    @set("janelaSucesso", @$("#jan-escolha-lab-sucesso"))
    @set("janelaErro", @$("#jan-escolha-lab-erro"))
    @set("janelaSpinner", @$("#jan-escolha-lab-spinner"))

  inicializarEstadoDivs: ->
    @get("janelaSpinner").show()
    @get("janelaErro").hide()
    @get("janelaSucesso").hide()
    @alternarJanela(proximaDiv: @get("janelaSpinner"))

)

export default BootstrapModalsEscolhaLaboratorioComponent
