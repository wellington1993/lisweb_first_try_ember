import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'bootstrap/navtab-cadastro-pessoa', 'Integration | Component | bootstrap/navtab cadastro pessoa', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{bootstrap/navtab-cadastro-pessoa}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#bootstrap/navtab-cadastro-pessoa}}
      template block text
    {{/bootstrap/navtab-cadastro-pessoa}}
  """

  assert.equal @$().text().trim(), 'template block text'
