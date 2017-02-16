import Ember from 'ember'

RequestsNonEmberDataRequestsMixin = Ember.Mixin.create(

  store: Ember.inject.service()

  doAjax: (params) ->

    #Obtém o adapter da aplicação.
    applicationAdapter = @get("store").adapterFor("application")

    #Prepara os parâmetros para a chmada do AJAX.
    ajaxParams = params

    #Considera o host do adapter da aplicação.
    if !params["skipAdapterHost"]

      finalURL = applicationAdapter.get("host")

      if params.hasOwnProperty("url")
        finalURL = finalURL + params["url"]

      ajaxParams["url"] = finalURL

    #Considera os headers do adapter da aplicação.
    if !params["skipAdapterHeaders"]
      ajaxParams["headers"] = application.get("headers")

    #Se possui callback customizado: 
    if params.hasOwnProperty("applicationCallback")

      ajaxParams["success"] = (data, status, response) ->
        params["applicationCallback"](true, data, response.status)

      ajaxParams["error"] = (response) ->
        params["applicationCallback"](false, null, response.status)

    return $.ajax(ajaxParams)

)

export default RequestsNonEmberDataRequestsMixin
