import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from './abstract-routes/private-route'

CadastrarTipoDePessoaRoute = AbstractRoutesPrivateRouteRoute.extend(

  actions:

    actRedirecionarAposCadastro: ->
      @transitionTo("tipos-de-pessoa")

)

export default CadastrarTipoDePessoaRoute
