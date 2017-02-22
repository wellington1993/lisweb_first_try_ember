import Ember from 'ember'
import RequestsUnidadeMedidaMixin from '../../../mixins/requests/unidade-medida'
import { module, test } from 'qunit'

module 'Unit | Mixin | requests/unidade medida'

# Replace this with your real tests.
test 'it works', (assert) ->
  RequestsUnidadeMedidaObject = Ember.Object.extend RequestsUnidadeMedidaMixin
  subject = RequestsUnidadeMedidaObject.create()
  assert.ok subject
