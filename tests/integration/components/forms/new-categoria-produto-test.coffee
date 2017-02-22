import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'forms/new-categoria-produto', 'Integration | Component | forms/new categoria produto', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{forms/new-categoria-produto}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#forms/new-categoria-produto}}
      template block text
    {{/forms/new-categoria-produto}}
  """

  assert.equal @$().text().trim(), 'template block text'
