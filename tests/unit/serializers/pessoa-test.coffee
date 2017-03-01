import { moduleForModel, test } from 'ember-qunit'

moduleForModel 'pessoa', 'Unit | Serializer | pessoa',
  # Specify the other units that are required for this test.
  needs: ['serializer:pessoa']

# Replace this with your real tests.
test 'it serializes records', (assert) ->
  record = @subject()

  serializedRecord = record.serialize()

  assert.ok serializedRecord
