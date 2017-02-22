import Ember from 'ember'

CadastrarCategoriaDeProdutoRoute = Ember.Route.extend(

  actions:

    actRedirecionarAposCadastro: ->
      @transitionTo("categorias-de-produto")

)

export default CadastrarCategoriaDeProdutoRoute
