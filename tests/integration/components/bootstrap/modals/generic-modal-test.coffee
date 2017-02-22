import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'bootstrap/modals/generic-modal', 'Integration | Component | bootstrap/modals/generic modal', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{bootstrap/modals/generic-modal}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#bootstrap/modals/generic-modal}}
      template block text
    {{/bootstrap/modals/generic-modal}}
  """

  assert.equal @$().text().trim(), 'template block text'
