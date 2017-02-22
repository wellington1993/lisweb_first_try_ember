import Ember from 'ember'

UtilsMixin = Ember.Mixin.create(

  intForArray: (numInt) ->

    retorno = []

    if !numInt
      return retorno

    numInt  = parseInt(numInt)

    i = 1
    while i <= numInt
      retorno.push(i)
      i++

    return retorno


)

export default UtilsMixin
