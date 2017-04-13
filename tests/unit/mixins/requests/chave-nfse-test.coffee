import Ember from 'ember'
import ChaveNfseMixin from '../../../mixins/requests/chave-nfse'
import { module, test } from 'qunit'

module 'Unit | Mixin | requests/chave-nfse'

# Replace this with your real tests.
test 'it works', (assert) ->
  ChaveNfseObject = Ember.Object.extend ChaveNfseMixin
  subject = ChaveNfseObject.create()
  assert.ok subject
