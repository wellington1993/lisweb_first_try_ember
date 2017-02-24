import Ember from 'ember'

RequestsPessoaMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  cadastrarPessoa: (context, options, callback = ->) ->

    if options.hasOwnProperty("pessoa")
      return options["pessoa"].save()
    else
      return @get("store").createRecord("pessoa", options["attrs"]).save()

  atualizarPessoa: (context, options, callback = ->) ->
    
    if options.hasOwnProperty("pessoa")
      return options["pessoa"].save()
    else
      return @get("store").createRecord("pessoa", options["attrs"]).save()

)

export default RequestsPessoaMixin
