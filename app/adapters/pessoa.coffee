import DS from 'ember-data'
import ApplicationAdapter from './application'

PessoaAdapter = ApplicationAdapter.extend(

  urlForQueryRecord: (query, modelName) ->

    finalUrl = @_super(query, modelName)

    if query.hasOwnProperty("action")

      if ["obterIdentificacao", "obterEnderecamento", "obterContato"].indexOf(query["action"]) > -1
        finalUrl = @get("host") + "/pessoas/#{query["id"]}/" + (query["action"].replace("obter", "").toLowerCase())

      delete query["action"]
      delete query["id"]

    return finalUrl

)

export default PessoaAdapter
