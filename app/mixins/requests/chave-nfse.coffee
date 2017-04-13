import Ember from 'ember'

RequestsChaveNfseMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  cadastrarChaveNfse: (context, options, callback = ->) ->

    if options.hasOwnProperty("chaveNfse")
      return options["chaveNfse"].save()
    else
      return @get("store").createRecord("chave-nfse", options["attrs"]).save()

  atualizarChaveNfse: (context, options, callback = ->) ->

    if options.hasOwnProperty("chaveNfse")
      return options["chaveNfse"].save()
    # else
    #   return @get("store").createRecord("chave-nfse", options["attrs"]).save()

)

export default RequestsChaveNfseMixin
