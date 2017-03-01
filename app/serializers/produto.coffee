import DS from 'ember-data'
import ApplicationSerializer from './application'

ProdutoSerializer = ApplicationSerializer.extend(

  serializeHasMany: (snapshot, json, relationship) ->

    if !snapshot.record.get("isNew")
      return @_super(snapshot, json, relationship)

    records = snapshot.record.get(relationship.key)

    if records.get("length") == 0
      return

    newKey = relationship.key.underscore() + "_attributes"

    json[newKey] = []

    records.forEach(
      (r) ->
        json[newKey].pushObject(r.serialize())
    )

    return json

)

export default ProdutoSerializer
