import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'forms/new-unidade-medida', 'Integration | Component | forms/new unidade medida', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{forms/new-unidade-medida}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#forms/new-unidade-medida}}
      template block text
    {{/forms/new-unidade-medida}}
  """

  assert.equal @$().text().trim(), 'template block text'
