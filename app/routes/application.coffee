import Ember from 'ember'
import ApplicationRouteMixin from 'ember-simple-auth/mixins/application-route-mixin'
import RequestsLaboratorioMixin from "../mixins/requests/laboratorio"

ApplicationRoute = Ember.Route.extend(ApplicationRouteMixin, RequestsLaboratorioMixin,

  model: ->
    return @obterLaboratorioAtual()
)

export default ApplicationRoute
