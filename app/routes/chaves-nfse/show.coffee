import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

ChavesNfseShowRoute = AbstractRoutesPrivateRouteRoute.extend(

  model: (params, transition) ->
    self = @
    chaveNfse =
      @get("store").findRecord("chave-nfse", params["chave_nfse_id"], reload: true).then(
        (data) ->
          return data
        (err) ->
          self.transitionTo("chaves-nfse/index")
       )
     return chaveNfse

  actions:
    #Se os atributos foram alterados e não salvos ao sair da rota as alterações
    #devem ser desfeitas.
    willTransition: ->
      @controllerFor("chaves-nfse/show").get("model").rollbackAttributes()

    actRedirecionar: ->
      @transitionTo("chaves-nfse/index")
)

export default ChavesNfseShowRoute
