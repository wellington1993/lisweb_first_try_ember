import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'inputs/mask-telefone', 'Integration | Component | inputs/mask telefone', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{inputs/mask-telefone}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#inputs/mask-telefone}}
      template block text
    {{/inputs/mask-telefone}}
  """

  assert.equal @$().text().trim(), 'template block text'
