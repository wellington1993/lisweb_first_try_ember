import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'forms/new-tipo-pessoa', 'Integration | Component | forms/new tipo pessoa', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{forms/new-tipo-pessoa}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#forms/new-tipo-pessoa}}
      template block text
    {{/forms/new-tipo-pessoa}}
  """

  assert.equal @$().text().trim(), 'template block text'
