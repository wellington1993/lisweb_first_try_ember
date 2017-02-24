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

  keyForAttribute: (key, method) ->
    if method == "serialize"
      return key.underscore()
    else
      return key.camelize()

  keyForRelationship: (key, relationship, method) ->

    relationshipKey = null

    if method == "serialize"
      relationshipKey = key.underscore() + "_id"
    else
      relationshipKey = key.camelize() + "Id"

    return relationshipKey

  serializeAttribute: (snapshot, json, key, attribute) ->

    model = snapshot.record

    if !model.get("isNew")

      changedAttrs = model.changedAttributes()

      changedAttrsKeys = Object.keys(model.changedAttributes())

      if !(changedAttrsKeys.indexOf(key) > -1)
        return

      oldValue = changedAttrs[key][0]
      newValue = changedAttrs[key][1]

      if (!newValue || new String(newValue).trim().length == 0) && (!oldValue || new String(oldValue).trim().length == 0)
        return

    return @_super(snapshot, json, key, attribute)

)

export default ApplicationSerializer
