import Ember from 'ember'

DashboardButtonComponent = Ember.Component.extend(

  didInsertElement: ->

    self = @

    @$().css("cursor", "pointer")

    @$(".panel").hover(
      ->
        $(@).addClass("panel-primary")
      ->
        $(@).removeClass("panel-primary")
    )

    @$().on("click touchstart",
      ->
        self.sendAction("actionOnClick", self.get("refParam"))
    )

)

export default DashboardButtonComponent
