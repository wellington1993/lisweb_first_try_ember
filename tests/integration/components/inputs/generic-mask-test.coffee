import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'inputs/generic-mask', 'Integration | Component | inputs/generic mask', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{inputs/generic-mask}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#inputs/generic-mask}}
      template block text
    {{/inputs/generic-mask}}
  """

  assert.equal @$().text().trim(), 'template block text'
