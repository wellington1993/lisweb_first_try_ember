import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'
import RequestsPessoaMixin from '../../mixins/requests/pessoa'

PessoaContatoRoute = AbstractRoutesPrivateRouteRoute.extend(RequestsPessoaMixin,

  model: (params, transition) ->

    self = @

    @obterIdentificacao(pessoaId: transition.params.pessoa.id).then(
      (data) ->
        return data
      (err) ->
        self.transitionTo("pessoas")
    )

)
export default PessoaContatoRoute
