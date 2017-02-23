import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'inputs/mask-cpf', 'Integration | Component | inputs/mask cpf', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{inputs/mask-cpf}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#inputs/mask-cpf}}
      template block text
    {{/inputs/mask-cpf}}
  """

  assert.equal @$().text().trim(), 'template block text'
