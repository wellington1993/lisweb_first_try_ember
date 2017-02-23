import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'
import RequestsPessoaMixin from '../../mixins/requests/pessoa'

PessoaEnderecamentoRoute = AbstractRoutesPrivateRouteRoute.extend(RequestsPessoaMixin,

  model: (params, transition) ->

    self = @

    @obterEnderecamento(pessoaId: transition.params.pessoa.id).then(
      (data) ->
        return data
      (err) ->
        self.transitionTo("pessoas")
    )

)
export default PessoaEnderecamentoRoute
