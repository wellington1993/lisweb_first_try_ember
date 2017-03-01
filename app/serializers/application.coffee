import DS from 'ember-data'

ApplicationSerializer = DS.RESTSerializer.extend(

  #Assegura que a chave do JSON principal seja underscore e não camelCase.
  payloadKeyFromModelName: (modelName) ->
    return modelName.underscore()


  #Assegura que os atributos do JSON sejam sempre underscore e não camelCase.
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


  #Assegura que todos os atributos do JSON a ser enviado sejam under_score
  #e os atributos recebidos da API sejam camelCase.
  keyForAttribute: (key, method) ->
    if method == "serialize"
      return key.underscore()
    else
      return key.camelize()

  #Concatena a extensão _ID ou id para os relacionamentos.
  keyForRelationship: (key, relationship, method) ->

    relationshipKey = null

    if method == "serialize"
      relationshipKey = key.underscore() + "_id"
    else
      relationshipKey = key.camelize() + "Id"

    return relationshipKey

  #Se é um update deve serializar apenas os atributos alterados.
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

    else

      value = snapshot.record.get(key)

      if !value || new String(value).trim().length == 0
        return

    return @_super(snapshot, json, key, attribute)

)

export default ApplicationSerializer
