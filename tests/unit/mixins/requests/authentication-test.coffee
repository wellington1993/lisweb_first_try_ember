import Ember from 'ember'
import RequestsAuthenticationMixin from '../../../mixins/requests/authentication'
import { module, test } from 'qunit'

module 'Unit | Mixin | requests/authentication'

# Replace this with your real tests.
test 'it works', (assert) ->
  RequestsAuthenticationObject = Ember.Object.extend RequestsAuthenticationMixin
  subject = RequestsAuthenticationObject.create()
  assert.ok subject
