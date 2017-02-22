import { moduleFor, test } from 'ember-qunit'

moduleFor 'route:cadastrar-categoria-de-produto', 'Unit | Route | cadastrar categoria de produto', {
  # Specify the other units that are required for this test.
  # needs: ['controller:foo']
}

test 'it exists', (assert) ->
  route = @subject()
  assert.ok route
