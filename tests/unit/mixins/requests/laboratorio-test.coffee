import Ember from 'ember'
import RequestsLaboratorioMixin from '../../../mixins/requests/laboratorio'
import { module, test } from 'qunit'

module 'Unit | Mixin | requests/laboratorio'

# Replace this with your real tests.
test 'it works', (assert) ->
  RequestsLaboratorioObject = Ember.Object.extend RequestsLaboratorioMixin
  subject = RequestsLaboratorioObject.create()
  assert.ok subject
