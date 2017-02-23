import Ember from 'ember'
import RequestsEnderecoMixin from '../../../mixins/requests/endereco'
import { module, test } from 'qunit'

module 'Unit | Mixin | requests/endereco'

# Replace this with your real tests.
test 'it works', (assert) ->
  RequestsEnderecoObject = Ember.Object.extend RequestsEnderecoMixin
  subject = RequestsEnderecoObject.create()
  assert.ok subject
