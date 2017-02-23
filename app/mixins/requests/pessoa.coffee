import Ember from 'ember'

RequestsPessoaMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  obterIdentificacao: (params) ->
    return @get("store").queryRecord("pessoa", action: "obterIdentificacao", id: params["pessoaId"])

  obterEnderecamento: (params) ->
    return @get("store").queryRecord("pessoa", action: "obterEnderecamento", id: params["pessoaId"])

  obterContato: (params) ->
    return @get("store").queryRecord("pessoa", action: "obterContato", id: params["pessoaId"])

)

export default RequestsPessoaMixin
