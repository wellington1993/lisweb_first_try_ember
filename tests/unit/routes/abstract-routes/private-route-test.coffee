import { moduleFor, test } from 'ember-qunit'

moduleFor 'route:abstract-routes/private-route', 'Unit | Route | abstract routes/private route', {
  # Specify the other units that are required for this test.
  # needs: ['controller:foo']
}

test 'it exists', (assert) ->
  route = @subject()
  assert.ok route
