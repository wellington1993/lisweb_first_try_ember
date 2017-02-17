import Ember from 'ember'
import UtilsComponentsFormMixin from '../../../mixins/utils/components/form'
import { module, test } from 'qunit'

module 'Unit | Mixin | utils/components/form'

# Replace this with your real tests.
test 'it works', (assert) ->
  UtilsComponentsFormObject = Ember.Object.extend UtilsComponentsFormMixin
  subject = UtilsComponentsFormObject.create()
  assert.ok subject
