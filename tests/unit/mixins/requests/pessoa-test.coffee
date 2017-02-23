import Ember from 'ember'
import RequestsPessoaMixin from '../../../mixins/requests/pessoa'
import { module, test } from 'qunit'

module 'Unit | Mixin | requests/pessoa'

# Replace this with your real tests.
test 'it works', (assert) ->
  RequestsPessoaObject = Ember.Object.extend RequestsPessoaMixin
  subject = RequestsPessoaObject.create()
  assert.ok subject
