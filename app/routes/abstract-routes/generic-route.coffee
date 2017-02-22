import Ember from 'ember'

AbstractRoutesGenericRouteRoute = Ember.Route.extend(

  applicationSession: Ember.inject.service()

  queryParams:
    page:
      refreshModel: true

  activate: ->
    $("html, body").animate({ scrollTop: 0 }, "slow")

  paginar: (params, callbackAfterPaginate) ->
    callbackAfterPaginate(false)

    queryParams = page: params["page"]
    queryParams = @determinarParametrosAdicionaisPaginacao(queryParams)

    @transitionTo(@currentPath(), queryParams: queryParams)
    @activate()

  determinarParametrosAdicionaisPaginacao: (params) ->
    return params

  currentPath: ->
    @controllerFor("application").get("currentPath")

  setupControllerWithPagination: (controller, model) ->

    pagination = null

    try
      pagination = model.get("meta")["pagination"]
    catch e

    controller.set("pagination", pagination)

  paramsToUseQueryAsFindAll: (existingParams = {}) ->
    existingParams["action"] = "findAll"
    return existingParams

  actions:

    actPaginar: (page, callbackAfterPaginate) ->
      @paginar(page: page, callbackAfterPaginate)

)

export default AbstractRoutesGenericRouteRoute
