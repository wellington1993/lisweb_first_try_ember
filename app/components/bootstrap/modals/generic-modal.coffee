import Ember from 'ember'
import UtilsComponentsBootstrapModalMixin from '../../../mixins/utils/components/bootstrap/modal'
import UtilsComponentsDivTransitionMixin from '../../../mixins/utils/components/div-transition'

BootstrapModalsGenericModalComponent = Ember.Component.extend(UtilsComponentsBootstrapModalMixin, UtilsComponentsDivTransitionMixin,

  #Este modal deve ser utilizado apenas para herança. As configurações globais
  #de todos os modais da aplicação devem ser atribuídas neste componente.

  actions:

    #Utilizar apenas para testes:
    #Action de teste para quando o botão do componente for clicado abrir o modal
    #genéerico.
    actAbrirModalTeste: ->
      @abrirModal(@$(".modal"))

)

export default BootstrapModalsGenericModalComponent
