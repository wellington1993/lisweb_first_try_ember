import Ember from 'ember'

RequestsMarcaMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  cadastrarMarca: (context, options, callback = ->) ->

    if options.hasOwnProperty("marca")
      return options["marca"].save()
    else
      return @get("store").createRecord("marca", options["attrs"]).save()

  atualizarMarca: (context, options, callback = ->) ->

    if options.hasOwnProperty("marca")
      return options["marca"].save()

)

export default RequestsMarcaMixin
