import Ember from 'ember'

UtilsComponentsBootstrapModalMixin = Ember.Mixin.create(

  abrirModal: (modalSeletorJquery, options = null ) ->

    if options == null
      options = backdrop: "static", keyboard: false

    modalSeletorJquery.modal(options)

)

export default UtilsComponentsBootstrapModalMixin
