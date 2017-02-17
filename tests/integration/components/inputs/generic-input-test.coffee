import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'inputs/generic-input', 'Integration | Component | inputs/generic input', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{inputs/generic-input}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#inputs/generic-input}}
      template block text
    {{/inputs/generic-input}}
  """

  assert.equal @$().text().trim(), 'template block text'
