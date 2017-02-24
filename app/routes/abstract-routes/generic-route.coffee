import Ember from 'ember'

#Rota genérica (todas as rotas da aplicação herdam diretamente ou indiretamente desta rota)

AbstractRoutesGenericRouteRoute = Ember.Route.extend(

  applicationSession: Ember.inject.service()

  #Sempre que a página receber o atributo "page" a hook "model" deve ser chamada.
  queryParams:
    page:
      refreshModel: true

  #Ao entrar na rota o cursor deve ser movido para o top.
  activate: ->
    $("html, body").animate({ scrollTop: 0 }, "slow")

  #Realiza a paginação.
  paginar: (params, callbackAfterPaginate) ->

    callbackAfterPaginate(false)

    #Prepara as query params para serem enviadas para a próxima rota.
    queryParams = page: params["page"]
    queryParams = @determinarParametrosAdicionaisPaginacao(queryParams)

    #Redireciona para a próxima rota com os atributos de paginação.
    @transitionTo(@currentPath(), queryParams: queryParams)

    #Inicializa o scroll.
    @activate()

  #Determina quais parâmetros devem ser passados para a rota ao fazer paginação.
  determinarParametrosAdicionaisPaginacao: (params) ->
    return params

  #Obtém o nome da rota atual.
  currentPath: ->
    @controllerFor("application").get("currentPath")

  #Método para ao configurar o controler (método setupController) os dados de
  #paginação também sejam inseridos no controlador.
  setupControllerWithPagination: (controller, model) ->

    pagination = null

    try
      pagination = model.get("meta")["pagination"]
    catch e

    controller.set("pagination", pagination)

  #Parametros para quando o método store.query for utilizado, tenha o mesmo
  #comportamento/resultado do método findAll.
  paramsToUseQueryAsFindAll: (existingParams = {}) ->
    existingParams["action"] = "findAll"
    return existingParams

  actions:

    #Action para realizar a paginação.
    actPaginar: (page, callbackAfterPaginate) ->
      @paginar(page: page, callbackAfterPaginate)

)

export default AbstractRoutesGenericRouteRoute
