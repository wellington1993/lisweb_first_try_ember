import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'bootstrap/modals/escolha-laboratorio', 'Integration | Component | bootstrap/modals/escolha laboratorio', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{bootstrap/modals/escolha-laboratorio}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#bootstrap/modals/escolha-laboratorio}}
      template block text
    {{/bootstrap/modals/escolha-laboratorio}}
  """

  assert.equal @$().text().trim(), 'template block text'
