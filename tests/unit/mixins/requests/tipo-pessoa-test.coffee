import Ember from 'ember'
import RequestsTipoPessoaMixin from '../../../mixins/requests/tipo-pessoa'
import { module, test } from 'qunit'

module 'Unit | Mixin | requests/tipo pessoa'

# Replace this with your real tests.
test 'it works', (assert) ->
  RequestsTipoPessoaObject = Ember.Object.extend RequestsTipoPessoaMixin
  subject = RequestsTipoPessoaObject.create()
  assert.ok subject
