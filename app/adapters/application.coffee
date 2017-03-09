import DS from 'ember-data'
import ENV from '../config/environment'
import DataAdapterMixin from 'ember-simple-auth/mixins/data-adapter-mixin'

ApplicationAdapter = DS.RESTAdapter.extend(DataAdapterMixin,

  #O host do adapter é definido no arquivo /config/environment.js.
  host: ENV.host

  #Define o authorizer da aplicação para, quando autenticado, todas as requests
  #do Ember-Data estejam autorizadas.
  authorizer: 'authorizer:application'

  #Tratamento para códigos HTTP específicos recebidos pelo Ember Data.
  handleResponse: (status, headers, payload, requestData) ->

    #Caso o código seja 403 (não autorizado: )
    if status == 403
      window.location.href = "/nao-autorizado"
    else
      return @_super(status, headers, payload, requestData)

  #Faz com que o nome dos endpoints que se refiram a models seja convertidos
  #de camelcase para underscore e no plural.
  #Ex: model TipoPessoa deve utilizar o endpoint /tipos_pessoa e não /tipoPessoa
  pathForType: (modelName) ->
    return modelName.pluralize().underscore()

  #Faz com que o endpoint default do método "query" seja o mesmo endpoint do
  #método findAll. Pois o método findAll do Ember não suporta metadados.
  urlForQuery: (query, modelName) ->

    try
      if query.action == "findAll"
        return @urlForFindAll(modelName, null)
    catch e

    return @_super(query, modelName)

  #Realiza tratamento para quando o método possui o parâmetro "action."
  query: (store, type, query) ->

    #Se a action é findAll o atributo da query deve ser excluído.
    if query.hasOwnProperty("action") && query["action"] == "findAll"
      delete query["action"]

    return @_super(store, type, query)

  #Realiza tratamento para models que possui endpoint diferente do padrão.
  buildURL: (modelName, id, snapshot, requestType, query) ->

    url = null

    try

      record = snapshot.record
      host   = @get("host")

      switch modelName

        when "produto"

          url = "#{host}/tipos_produto/#{record.get("tipoProduto.id")}/produtos"

        when "fornecedor-produto"
          url = "#{host}/tipos_produto/#{record.get("produto.tipoProduto.id")}/produtos/#{record.get("produto.id")}/fornecedores_produto"

        when "unidade-medida-entrada"

          url = "#{host}/tipos_produto/#{record.get("produto.tipoProduto.id")}/produtos/#{record.get("produto.id")}/unidades_medida_entrada"

      if url != null && id
        url = url + "/" + id

    catch

    if url == null
      return @_super(modelName, id, snapshot, requestType, query)

    return url

)

export default ApplicationAdapter
