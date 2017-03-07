import Ember from 'ember'

RequestsTipoPessoaMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  cadastrarTipoPessoa: (context, options, callback = ->) ->

    if options.hasOwnProperty("tipoPessoa")
      return options["tipoPessoa"].save()
    else
      return @get("store").createRecord("tipo-pessoa", options["attrs"]).save()

  atualizarTipoPessoa: (context, options, callback = ->) ->

    if options.hasOwnProperty("tipoPessoa")
      return options["tipoPessoa"].save()


)

export default RequestsTipoPessoaMixin
