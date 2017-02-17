import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'box-login', 'Integration | Component | box login', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{box-login}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#box-login}}
      template block text
    {{/box-login}}
  """

  assert.equal @$().text().trim(), 'template block text'
