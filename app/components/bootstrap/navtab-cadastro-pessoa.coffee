import Ember from 'ember'

BootstrapNavtabCadastroPessoaComponent = Ember.Component.extend(

  actionOnClick: null

  didInsertElement: ->

    arrayRef = window.location.href.split("/")
    segmento = arrayRef[arrayRef.length - 1]
    @$('.nav-tabs a[href="#tab-pessoa-' + segmento + '"]').tab('show');

  actions:

    actRedirecionar: (nomeRota) ->
      @sendAction("actionOnClick", nomeRota)

)

export default BootstrapNavtabCadastroPessoaComponent
