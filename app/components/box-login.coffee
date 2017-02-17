import Ember from 'ember'

BoxLoginComponent = Ember.Component.extend(

  applicationSession: Ember.inject.service()

  actions:

    authenticate: ->

      self = @

      data = @getProperties('identification', 'password')

      @get("applicationSession").login(email: data["identification"], password: data["password"],
        (success, data) ->

          if !success
            self.set("errorMessage", data.error)

      )
)

export default BoxLoginComponent
