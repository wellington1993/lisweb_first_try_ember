import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'
import RequestsPessoaMixin from '../../mixins/requests/pessoa'

PessoaIdentificacaoRoute = AbstractRoutesPrivateRouteRoute.extend(RequestsPessoaMixin,

  currentPath: "43243423"

  model: (params, transition) ->

    self = @

    @obterIdentificacao(pessoaId: transition.params.pessoa.id).then(
      (data) ->
        return data
      (err) ->
        self.transitionTo("pessoas")
    )
)
export default PessoaIdentificacaoRoute
