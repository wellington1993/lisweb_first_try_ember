import Ember from 'ember'
import UtilsComponentsInputMixin from '../../../mixins/utils/components/input'
import { module, test } from 'qunit'

module 'Unit | Mixin | utils/components/input'

# Replace this with your real tests.
test 'it works', (assert) ->
  UtilsComponentsInputObject = Ember.Object.extend UtilsComponentsInputMixin
  subject = UtilsComponentsInputObject.create()
  assert.ok subject
