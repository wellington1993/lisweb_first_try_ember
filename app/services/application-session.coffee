import Ember from 'ember'

ApplicationSessionService = Ember.Service.extend(

  session: Ember.inject.service()

  login: (params, callback) ->


  logout: (params, callback) ->


  sessionStillValid: (params, callback) ->

    

)

export default ApplicationSessionService
