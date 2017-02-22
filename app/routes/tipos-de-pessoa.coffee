import Ember from 'ember'

TiposDePessoaRoute = Ember.Route.extend(

  model: ->
    @get("store").findAll("tipo-pessoa")

)

export default TiposDePessoaRoute
