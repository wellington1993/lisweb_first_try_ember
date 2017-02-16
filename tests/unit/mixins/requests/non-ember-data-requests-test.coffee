import Ember from 'ember'
import RequestsNonEmberDataRequestsMixin from '../../../mixins/requests/non-ember-data-requests'
import { module, test } from 'qunit'

module 'Unit | Mixin | requests/non ember data requests'

# Replace this with your real tests.
test 'it works', (assert) ->
  RequestsNonEmberDataRequestsObject = Ember.Object.extend RequestsNonEmberDataRequestsMixin
  subject = RequestsNonEmberDataRequestsObject.create()
  assert.ok subject
