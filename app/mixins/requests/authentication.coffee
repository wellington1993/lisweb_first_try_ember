import Ember from 'ember'
import RequestsNonEmberDataRequestsMixin from './non-ember-data-requests'

RequestsAuthenticationMixin = Ember.Mixin.create(RequestsNonEmberDataRequestsMixin,

  userTokenStillValid: (params, callback) ->

    url = "/users/me"

    data =
      token: params["token"]
      email: params["email"]

    @doAjax(
      url: url
      type: "POST"
      data: data
      applicationCallback: callback
    )

)

export default RequestsAuthenticationMixin
