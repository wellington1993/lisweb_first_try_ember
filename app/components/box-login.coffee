import Ember from 'ember'

BoxLoginComponent = Ember.Component.extend(

  session: Ember.inject.service()

  actions:

    authenticate: ->

      self = @

      data = @getProperties('identification', 'password')

      @get('session').authenticate('authenticator:application', data["identification"], data["password"]).catch(
        (reason) =>
          @set('errorMessage', reason.error)
      )

)

export default BoxLoginComponent
