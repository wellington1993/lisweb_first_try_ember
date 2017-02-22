import { moduleFor, test } from 'ember-qunit'

moduleFor 'route:unidades-de-medida', 'Unit | Route | unidades de medida', {
  # Specify the other units that are required for this test.
  # needs: ['controller:foo']
}

test 'it exists', (assert) ->
  route = @subject()
  assert.ok route
