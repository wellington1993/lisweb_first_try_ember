import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'bootstrap/dynamic-pagination', 'Integration | Component | bootstrap/dynamic pagination', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{bootstrap/dynamic-pagination}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#bootstrap/dynamic-pagination}}
      template block text
    {{/bootstrap/dynamic-pagination}}
  """

  assert.equal @$().text().trim(), 'template block text'
