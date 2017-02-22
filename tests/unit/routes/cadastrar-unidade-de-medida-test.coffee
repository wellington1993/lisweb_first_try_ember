import { moduleFor, test } from 'ember-qunit'

moduleFor 'route:cadastrar-unidade-de-medida', 'Unit | Route | cadastrar unidade de medida', {
  # Specify the other units that are required for this test.
  # needs: ['controller:foo']
}

test 'it exists', (assert) ->
  route = @subject()
  assert.ok route
