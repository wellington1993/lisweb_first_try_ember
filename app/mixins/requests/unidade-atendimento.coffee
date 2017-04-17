import Ember from 'ember'

RequestsUnidadeAtendimentoMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  cadastrarUnidadeAtendimento: (context, options, callback = ->) ->

    if options.hasOwnProperty("unidadeAtendimento")
      return options["unidadeAtendimento"].save()
    else
      return @get("store").createRecord("unidade-atendimento", options["attrs"]).save()

  atualizarUnidadeAtendimento: (context, options, callback = ->) ->

    if options.hasOwnProperty("unidadeAtendimento")
      return options["unidadeAtendimento"].save()
    # else
    #   return @get("store").createRecord("unidade-atendimento", options["attrs"]).save()

)

export default RequestsUnidadeAtendimentoMixin
