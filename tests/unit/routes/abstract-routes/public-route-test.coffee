import { moduleFor, test } from 'ember-qunit'

moduleFor 'route:abstract-routes/public-route', 'Unit | Route | abstract routes/public route', {
  # Specify the other units that are required for this test.
  # needs: ['controller:foo']
}

test 'it exists', (assert) ->
  route = @subject()
  assert.ok route
