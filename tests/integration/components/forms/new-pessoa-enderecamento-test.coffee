import { test, moduleForComponent } from 'ember-qunit'
import hbs from 'htmlbars-inline-precompile'

moduleForComponent 'forms/new-pessoa-enderecamento', 'Integration | Component | forms/new pessoa enderecamento', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{forms/new-pessoa-enderecamento}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#forms/new-pessoa-enderecamento}}
      template block text
    {{/forms/new-pessoa-enderecamento}}
  """

  assert.equal @$().text().trim(), 'template block text'
