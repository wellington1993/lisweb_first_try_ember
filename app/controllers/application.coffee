import Ember from 'ember'

ApplicationController = Ember.Controller.extend(

  applicationSession: Ember.inject.service()

  actions:

    logout: ->
      @get("applicationSession").logout({}, ->)

)

export default ApplicationController
