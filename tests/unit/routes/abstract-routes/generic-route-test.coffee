import { moduleFor, test } from 'ember-qunit'

moduleFor 'route:abstract-routes/generic-route', 'Unit | Route | abstract routes/generic route', {
  # Specify the other units that are required for this test.
  # needs: ['controller:foo']
}

test 'it exists', (assert) ->
  route = @subject()
  assert.ok route
