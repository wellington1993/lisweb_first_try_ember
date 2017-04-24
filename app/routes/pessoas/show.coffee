import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

PessoasShowRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->

    self = @

    pessoa  = @get("store").findRecord("pessoa", params["pessoa_id"], reload: true).then(
      (data) ->
        return data
      (err) ->

        self.transitionTo("pessoas/index")

    )
    tiposPessoa = @get("store").findAll("tipo-pessoa", reload: true)

    #O model deve receber a pessoa a ser editada + todos os tipos de pessoa
    #possíveis para serem utilizados no combobox de tipo de pessoa.
    return Ember.RSVP.hash(
      pessoa: pessoa
      tiposPessoa: tiposPessoa
    )

  actions:

    #Se os atributos foram alterados e não salvos ao sair da rota as alterações
    #devem ser desfeitas.
    willTransition: ->
      @controllerFor("pessoas/show").get("model")["pessoa"].rollbackAttributes()

    actRedirecionar: ->
      @transitionTo("pessoas/index")

)

export default PessoasShowRoute
