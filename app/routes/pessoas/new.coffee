import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

PessoasNewRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->

    self = @

    pessoa  = @get("store").createRecord("pessoa")

    tiposPessoa = @get("store").findAll("tipo-pessoa", reload: true)

    #O model deve receber a pessoa a ser editada + todos os tipos de pessoa
    #possíveis para serem utilizados no combobox de tipo de pessoa.
    return Ember.RSVP.hash(
      pessoa: pessoa
      tiposPessoa: tiposPessoa
    )

  actions:

    willTransition: ->
      model = @controllerFor("pessoas/new").get("model")["pessoa"]

      if model.get("isNew")
        @get("store").unloadRecord(model)

    actRedirecionar: ->
      @transitionTo("pessoas/index")


)

export default PessoasNewRoute
