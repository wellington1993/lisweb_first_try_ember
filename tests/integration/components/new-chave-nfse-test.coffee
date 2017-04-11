import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'new-chave-nfse', 'Integration | Component | new chave nfse', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{new-chave-nfse}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#new-chave-nfse}}
      template block text
    {{/new-chave-nfse}}
  """

  assert.equal @$().text().trim(), 'template block text'
