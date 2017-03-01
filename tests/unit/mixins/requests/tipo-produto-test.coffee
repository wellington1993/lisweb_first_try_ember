import Ember from 'ember'
import RequestsTipoProdutoMixin from '../../../mixins/requests/tipo-produto'
import { module, test } from 'qunit'

module 'Unit | Mixin | requests/tipo produto'

# Replace this with your real tests.
test 'it works', (assert) ->
  RequestsTipoProdutoObject = Ember.Object.extend RequestsTipoProdutoMixin
  subject = RequestsTipoProdutoObject.create()
  assert.ok subject
