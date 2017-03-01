import Ember from 'ember'

# This function receives the params `params, hash`
booleanToSimNao = (params) ->

  switch params[0]

    when true
      params[0] = "Sim"

    when false
      params[0] = "Não"

  return params[0]

BooleanToSimNaoHelper = Ember.Helper.helper booleanToSimNao

export { booleanToSimNao }

export default BooleanToSimNaoHelper
