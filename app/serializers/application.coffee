import DS from 'ember-data'

ApplicationSerializer = DS.RESTSerializer.extend(

  payloadKeyFromModelName: (modelName) ->
    return modelName.underscore()
)

export default ApplicationSerializer
