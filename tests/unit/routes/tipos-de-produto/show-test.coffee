import { moduleFor, test } from 'ember-qunit'

moduleFor 'route:tipos-de-produto/show', 'Unit | Route | tipos de produto/show', {
  # Specify the other units that are required for this test.
  # needs: ['controller:foo']
}

test 'it exists', (assert) ->
  route = @subject()
  assert.ok route
