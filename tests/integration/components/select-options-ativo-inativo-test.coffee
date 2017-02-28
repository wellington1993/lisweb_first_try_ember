import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'select-options-ativo-inativo', 'Integration | Component | select options ativo inativo', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{select-options-ativo-inativo}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#select-options-ativo-inativo}}
      template block text
    {{/select-options-ativo-inativo}}
  """

  assert.equal @$().text().trim(), 'template block text'
