import DS from 'ember-data'

ApplicationSerializer = DS.RESTSerializer.extend(

  payloadKeyFromModelName: (modelName) ->
    return modelName.underscore()

  normalize: (typeClass, hash) ->

    Object.keys(hash).forEach(

      (oldKey) ->

        newKey = oldKey.camelize()

        if newKey == oldKey
          return

        hash[newKey] = hash[oldKey]
        delete hash[oldKey]

    )


    return @_super(typeClass, hash)

  keyForRelationship: (key, relationship, method) ->

    relationshipKey = null

    if method == "serialize"
      relationshipKey = key.underscore() + "_id"
    else
      relationshipKey = key.camelize() + "Id"

    return relationshipKey
)

export default ApplicationSerializer
