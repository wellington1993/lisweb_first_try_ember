import Ember from 'ember'
import RequestsMarcaMixin from '../../../mixins/requests/marca'
import { module, test } from 'qunit'

module 'Unit | Mixin | requests/marca'

# Replace this with your real tests.
test 'it works', (assert) ->
  RequestsMarcaObject = Ember.Object.extend RequestsMarcaMixin
  subject = RequestsMarcaObject.create()
  assert.ok subject
