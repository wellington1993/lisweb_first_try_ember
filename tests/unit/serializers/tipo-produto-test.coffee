import { moduleForModel, test } from 'ember-qunit'

moduleForModel 'tipo-produto', 'Unit | Serializer | tipo produto',
  # Specify the other units that are required for this test.
  needs: ['serializer:tipo-produto']

# Replace this with your real tests.
test 'it serializes records', (assert) ->
  record = @subject()

  serializedRecord = record.serialize()

  assert.ok serializedRecord
