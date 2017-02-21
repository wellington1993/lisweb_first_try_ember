import { moduleFor, test } from 'ember-qunit'

moduleFor 'route:cadastrar-tipo-de-pessoa', 'Unit | Route | cadastrar tipo de pessoa', {
  # Specify the other units that are required for this test.
  # needs: ['controller:foo']
}

test 'it exists', (assert) ->
  route = @subject()
  assert.ok route
