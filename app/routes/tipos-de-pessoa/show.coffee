import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

TiposDePessoaShowRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->

    self = @

    tipoPessoa =
      @get("store").findRecord("tipo-pessoa", params["tipo_pessoa_id"], reload: true).then(

        (data) ->
          return data

        (err) ->
          self.transitionTo("tipos-de-pessoa/index")

       )

     return tipoPessoa

  actions:

    #Se os atributos foram alterados e não salvos ao sair da rota as alterações
    #devem ser desfeitas.
    willTransition: ->
      @controllerFor("tipos-de-pessoa/show").get("model").rollbackAttributes()

    actRedirecionar: ->
      @transitionTo("tipos-de-pessoa/index")

)

export default TiposDePessoaShowRoute
