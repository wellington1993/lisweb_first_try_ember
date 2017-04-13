import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'forms/new-chave-nfse', 'Integration | Component | forms/new chave-nfse', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{forms/new-chave-nfse}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#forms/new-chave-nfse}}
      template block text
    {{/forms/new-chave-nfse}}
  """

  assert.equal @$().text().trim(), 'template block text'
