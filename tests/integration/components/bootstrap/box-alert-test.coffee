import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'bootstrap/box-alert', 'Integration | Component | bootstrap/box alert', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{bootstrap/box-alert}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#bootstrap/box-alert}}
      template block text
    {{/bootstrap/box-alert}}
  """

  assert.equal @$().text().trim(), 'template block text'
