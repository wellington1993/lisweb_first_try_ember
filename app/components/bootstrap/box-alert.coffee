import Ember from 'ember'

BootstrapBoxAlertComponent = Ember.Component.extend(

  showCloseButton: false

  didInsertElement: ->

    if @get("showCloseButton")

      alert = @$(".alert")

      @$(".close").on("touchstart click",

        ->
          alert.fadeOut("fast")
      )

)

export default BootstrapBoxAlertComponent
