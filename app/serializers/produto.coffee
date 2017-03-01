import DS from 'ember-data'
import ApplicationSerializer from './application'

ProdutoSerializer = ApplicationSerializer.extend(

  serializeHasMany: (snapshot, json, relationship) ->

    if !snapshot.record.get("isNew")
      return @_super(snapshot, json, relationship)

    records = snapshot.record.get(relationship.key)

    if records.get("length") == 0
      return

    key    = relationship.key
    newKey = key.underscore() + "_attributes"

    json[newKey] = []

    records.forEach(

      (r, index) ->

        if key == "unidadesMedidaEntrada" && !r.get("ordem")
          r.set("ordem", (index + 1))

        json[newKey].pushObject(r.serialize())
    )

    return json

)

export default ProdutoSerializer
