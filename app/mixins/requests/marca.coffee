import Ember from 'ember'

RequestsMarcaMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  cadastrarMarca: (context, options, callback = ->) ->
    return options["marca"].save()


)

export default RequestsMarcaMixin
