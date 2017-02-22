import Ember from 'ember'
import UtilsComponentsBootstrapModalMixin from '../mixins/utils/components/bootstrap/modal'

LaboratoriosController = Ember.Controller.extend(UtilsComponentsBootstrapModalMixin,

  applicationSession: Ember.inject.service()

  laboratorioEscolhaModal: null

  actions:

    actEscolherLaboratorio: (idEscolhaLaboratorio) ->
      @set("laboratorioEscolhaModal", @get("store").peekRecord("laboratorio", idEscolhaLaboratorio))
      @abrirModal($("#modal-escolher-laboratorio").find(".modal"))


)

export default LaboratoriosController
