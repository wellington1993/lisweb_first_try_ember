import { moduleFor, test } from 'ember-qunit'

moduleFor 'route:cadastrar-tipo-de-produto', 'Unit | Route | cadastrar tipo de produto', {
  # Specify the other units that are required for this test.
  # needs: ['controller:foo']
}

test 'it exists', (assert) ->
  route = @subject()
  assert.ok route
