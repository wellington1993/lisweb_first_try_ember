import Ember from 'ember'

CategoriasDeProdutoRoute = Ember.Route.extend(

  model: ->
    return @get("store").findAll("categoria-produto")

)

export default CategoriasDeProdutoRoute
