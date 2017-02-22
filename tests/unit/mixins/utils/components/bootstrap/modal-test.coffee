import Ember from 'ember'
import UtilsComponentsBootstrapModalMixin from '../../../mixins/utils/components/bootstrap/modal'
import { module, test } from 'qunit'

module 'Unit | Mixin | utils/components/bootstrap/modal'

# Replace this with your real tests.
test 'it works', (assert) ->
  UtilsComponentsBootstrapModalObject = Ember.Object.extend UtilsComponentsBootstrapModalMixin
  subject = UtilsComponentsBootstrapModalObject.create()
  assert.ok subject
