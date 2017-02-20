import Ember from 'ember'

UtilsComponentsBootstrapBoxAlertMixin = Ember.Mixin.create(

  showMessage: (messageBoxSelector, params, callbackOnAnimationComplete) ->

    mensagem     = params["message"]
    tipoMensagem = params["type"]
    classeCor = "alert-" + tipoMensagem

    messageBoxSelector.fadeOut("fast"
      ->
        messageBoxSelector.removeClass("alert-danger alert-warning alert-success")
        messageBoxSelector.find(".form-alert-content").html(mensagem)
        messageBoxSelector.addClass(classeCor)
        messageBoxSelector.fadeIn("fast"
          ->
            callbackOnAnimationComplete()
        )
    )

  messageArrayToUlLiTags: (messageArray) ->

    stringFinal = ""

    messageArray.forEach(
      (iString) ->
        stringFinal = stringFinal + "<li>" + iString + "</li>"
    )

    return "<ul>" + stringFinal + "</ul>"

  hideMessage: (messageBoxSelector, params = {}, callbackOnAnimationComplete) ->

    messageBoxSelector.fadeOut("fast",
      ->
        callbackOnAnimationComplete()
    )


)

export default UtilsComponentsBootstrapBoxAlertMixin
