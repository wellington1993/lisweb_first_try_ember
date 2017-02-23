import Ember from 'ember'
import AbstractRoutesPrivateRouteRoute from '../abstract-routes/private-route'
import RequestsPessoaMixin from '../../mixins/requests/pessoa'

PessoaIdentificacaoRoute = AbstractRoutesPrivateRouteRoute.extend(RequestsPessoaMixin,

  currentPath: "43243423"

  model: (params, transition) ->

    self = @

    pessoaIdentificacao =

      @obterIdentificacao(pessoaId: transition.params.pessoa.id).then(
        (data) ->
          return data
        (err) ->
          self.transitionTo("pessoas")
      )

    tiposPessoa = @get("store").findAll("tipo-pessoa", reload: true)

    return Ember.RSVP.hash(
      pessoa: pessoaIdentificacao
      tiposPessoa: tiposPessoa
    )

)
export default PessoaIdentificacaoRoute
