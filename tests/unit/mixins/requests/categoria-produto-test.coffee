import Ember from 'ember'
import RequestsCategoriaProdutoMixin from '../../../mixins/requests/categoria-produto'
import { module, test } from 'qunit'

module 'Unit | Mixin | requests/categoria produto'

# Replace this with your real tests.
test 'it works', (assert) ->
  RequestsCategoriaProdutoObject = Ember.Object.extend RequestsCategoriaProdutoMixin
  subject = RequestsCategoriaProdutoObject.create()
  assert.ok subject
