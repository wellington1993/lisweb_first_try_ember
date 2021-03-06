import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'inputs/input-autocomplete', 'Integration | Component | inputs/input autocomplete', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{inputs/input-autocomplete}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#inputs/input-autocomplete}}
      template block text
    {{/inputs/input-autocomplete}}
  """

  assert.equal @$().text().trim(), 'template block text'
