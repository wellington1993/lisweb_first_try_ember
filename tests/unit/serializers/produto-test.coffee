import { moduleForModel, test } from 'ember-qunit'

moduleForModel 'produto', 'Unit | Serializer | produto',
  # Specify the other units that are required for this test.
  needs: ['serializer:produto']

# Replace this with your real tests.
test 'it serializes records', (assert) ->
  record = @subject()

  serializedRecord = record.serialize()

  assert.ok serializedRecord
