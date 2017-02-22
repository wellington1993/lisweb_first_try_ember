import Ember from 'ember'
import UtilsComponentsDivTransitionMixin from '../../../mixins/utils/components/div-transition'
import { module, test } from 'qunit'

module 'Unit | Mixin | utils/components/div transition'

# Replace this with your real tests.
test 'it works', (assert) ->
  UtilsComponentsDivTransitionObject = Ember.Object.extend UtilsComponentsDivTransitionMixin
  subject = UtilsComponentsDivTransitionObject.create()
  assert.ok subject
