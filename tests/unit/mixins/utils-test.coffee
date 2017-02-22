import Ember from 'ember'
import UtilsMixin from '../../../mixins/utils'
import { module, test } from 'qunit'

module 'Unit | Mixin | utils'

# Replace this with your real tests.
test 'it works', (assert) ->
  UtilsObject = Ember.Object.extend UtilsMixin
  subject = UtilsObject.create()
  assert.ok subject
