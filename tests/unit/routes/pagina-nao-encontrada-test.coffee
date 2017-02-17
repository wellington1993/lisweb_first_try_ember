import { moduleFor, test } from 'ember-qunit'

moduleFor 'route:pagina-nao-encontrada', 'Unit | Route | pagina nao encontrada', {
  # Specify the other units that are required for this test.
  # needs: ['controller:foo']
}

test 'it exists', (assert) ->
  route = @subject()
  assert.ok route
