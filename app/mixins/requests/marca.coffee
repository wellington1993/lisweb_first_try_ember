import Ember from 'ember'

RequestsMarcaMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  cadastrarMarca: (context, options, callback = ->) ->
    return @get("store").createRecord("marca", options["attrs"]).save()

)

export default RequestsMarcaMixin
