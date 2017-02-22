import Ember from 'ember'

# This function receives the params `params, hash`
tipoTipoPessoa = (params) ->

  switch params[0]

    when "PF"
      params[0] = "Pessoa Física"

    when "PJ"
      params[0] = "Pessoa Jurídica"

  return params[0]

TipoTipoPessoaHelper = Ember.Helper.helper tipoTipoPessoa

export { tipoTipoPessoa }

export default TipoTipoPessoaHelper
