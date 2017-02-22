import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'select-options-tipo-pessoa', 'Integration | Component | select options tipo pessoa', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{select-options-tipo-pessoa}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#select-options-tipo-pessoa}}
      template block text
    {{/select-options-tipo-pessoa}}
  """

  assert.equal @$().text().trim(), 'template block text'
