import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'forms/generic-form', 'Integration | Component | forms/generic form', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{forms/generic-form}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#forms/generic-form}}
      template block text
    {{/forms/generic-form}}
  """

  assert.equal @$().text().trim(), 'template block text'
