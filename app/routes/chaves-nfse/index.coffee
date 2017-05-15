import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'

ChavesNfseIndexRoute = AbstractRoutesPrivateRouteRoute.extend(
  model: (params, transition) ->
    params = @paramsToUseQueryAsFindAll(transition.queryParams)
    return @get("store").query("chave-nfse", params)

  setupController: (controller, model) ->
    @_super(controller, model)
    @setupControllerWithPagination(controller, model)

  actions:
    #Action para excluir a chave imediatamente.
    actExcluirChave: (chave) ->
      if (confirm('Deseja realmente excluir esta chave?'))
        chave.deleteRecord()
        #Obtem o ID da chave a ser excluida.
        id = chave.get("id")
        #Chama o metodo do ember data para exclusao imediata.
        chave.save().then(
          (d) ->
            alert("Chave #{id} excluída com sucesso!")
          (e) ->
            alert("Ocorreu um erro ao excluir a chave.")
        )
)

export default ChavesNfseIndexRoute
