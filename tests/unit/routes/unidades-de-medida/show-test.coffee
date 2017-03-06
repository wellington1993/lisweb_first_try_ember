import { moduleFor, test } from 'ember-qunit'

moduleFor 'route:unidades-de-medida/show', 'Unit | Route | unidades de medida/show', {
  # Specify the other units that are required for this test.
  # needs: ['controller:foo']
}

test 'it exists', (assert) ->
  route = @subject()
  assert.ok route
