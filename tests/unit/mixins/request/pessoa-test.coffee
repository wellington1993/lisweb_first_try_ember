import Ember from 'ember'
import RequestPessoaMixin from '../../../mixins/request/pessoa'
import { module, test } from 'qunit'

module 'Unit | Mixin | request/pessoa'

# Replace this with your real tests.
test 'it works', (assert) ->
  RequestPessoaObject = Ember.Object.extend RequestPessoaMixin
  subject = RequestPessoaObject.create()
  assert.ok subject
