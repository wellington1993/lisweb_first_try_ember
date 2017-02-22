import Ember from 'ember'

LaboratoriosController = Ember.Controller.extend(

  laboratorioEscolhaModal: null

  actions:

    actEscolherLaboratorio: (idEscolhaLaboratorio) ->
      @set("laboratorioEscolhaModal", @get("store").peekRecord("laboratorio", idEscolhaLaboratorio))
      console.log(@get("laboratorioEscolhaModal").get("nome"))

)

export default LaboratoriosController
