import { moduleFor, test } from 'ember-qunit'

moduleFor 'route:pessoas/show', 'Unit | Route | pessoas/show', {
  # Specify the other units that are required for this test.
  # needs: ['controller:foo']
}

test 'it exists', (assert) ->
  route = @subject()
  assert.ok route
