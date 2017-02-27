import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'forms/new-tipo-produto', 'Integration | Component | forms/new tipo produto', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{forms/new-tipo-produto}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#forms/new-tipo-produto}}
      template block text
    {{/forms/new-tipo-produto}}
  """

  assert.equal @$().text().trim(), 'template block text'
