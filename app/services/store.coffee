import Ember from 'ember'
import DS from 'ember-data'

StoreService = DS.Store.extend(

  #Método para fazer requisições AJAX sem o ember-data
  doAjax: (context, callback, ajaxParams = {}) ->

    #Obtém o adapter da aplicação.
    adapter = context.get("store").adapterFor("application")

    #Modulariza o callback do caller
    ajaxParams["success"] = (data, status, response) ->
      callback(true, data, response.status)

    ajaxParams["error"]   = (response) ->
      callback(false, null, response.status)

    #Concatena o host contido no adapter + endpoint de destino.
    if ajaxParams["url"].substring(0, 4) != "http"
      ajaxParams["url"] = adapter.get("host") + ajaxParams["url"]

    #Se o caller não definiu nenhum header, os headers são obtidos do adapter.
    if !ajaxParams.hasOwnProperty("headers") && !ajaxParams["overrideHeaders"]

      try
        adapterHeaders = adapter.headersForRequest()

        if adapterHeaders
          ajaxParams["headers"] = adapterHeaders
      catch e

    Ember.$.ajax(ajaxParams)

)

export default StoreService
