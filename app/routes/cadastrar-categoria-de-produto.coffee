import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from './abstract-routes/private-route'

CadastrarCategoriaDeProdutoRoute = AbstractRoutesPrivateRouteRoute.extend(

  actions:

    actRedirecionarAposCadastro: ->
      @transitionTo("categorias-de-produto")

)

export default CadastrarCategoriaDeProdutoRoute
