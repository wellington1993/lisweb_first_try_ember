import Ember from 'ember'
import ChavesNfseMixin from '../../../mixins/chaves-nfse'
import { module, test } from 'qunit'

module 'Unit | Mixin | chaves nfse'

# Replace this with your real tests.
test 'it works', (assert) ->
  ChavesNfseObject = Ember.Object.extend ChavesNfseMixin
  subject = ChavesNfseObject.create()
  assert.ok subject
