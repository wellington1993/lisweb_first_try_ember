import Ember from 'ember'
import FormsGenericFormComponent from './generic-form'

FormsLoginFormComponent = FormsGenericFormComponent.extend(

  applicationSession: Ember.inject.service()

  email: null
  senha: null

  fazerLogin: ->

    self = @

    dadosAcesso = @getProperties("email", "senha")

    @get("applicationSession").login(email: dadosAcesso["email"], password: dadosAcesso["senha"],

      (success, data) ->

        if !success
          self.set("errorMessage", data.error)

    )

  

  actions:

    actFazerLogin: ->
      @fazerLogin()

)

export default FormsLoginFormComponent
