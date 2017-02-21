import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'forms/new-marca', 'Integration | Component | forms/new marca', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{forms/new-marca}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#forms/new-marca}}
      template block text
    {{/forms/new-marca}}
  """

  assert.equal @$().text().trim(), 'template block text'
