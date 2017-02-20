import Ember from 'ember'
import UtilsComponentsBootstrapBoxAlertMixin from '../../../mixins/utils/components/bootstrap/box-alert'
import { module, test } from 'qunit'

module 'Unit | Mixin | utils/components/bootstrap/box alert'

# Replace this with your real tests.
test 'it works', (assert) ->
  UtilsComponentsBootstrapBoxAlertObject = Ember.Object.extend UtilsComponentsBootstrapBoxAlertMixin
  subject = UtilsComponentsBootstrapBoxAlertObject.create()
  assert.ok subject
