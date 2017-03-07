`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

TipoProdutoSerializer = ApplicationSerializer.extend(DS.EmbeddedRecordsMixin,

  attrs:
    produtos:
      deserialize: "records"

  #Tratamento para serializar os relacionamentos hasMany.
  serializeHasMany: (snapshot, json, relationship) ->

    #Se nao é um novo registro o tratamento deve ser similar ao da superclasse.
    if !snapshot.record.get("isNew")
      return @_super(snapshot, json, relationship)

    #Obtem os registros referes ao relacionamento.
    records = snapshot.record.get(relationship.key)

    #Se nao ha registros o processamento deve ser ignorado.
    if records.get("length") == 0
      return

    #Faz com que a chave do JSON seja o nome do relacionamento + "_attributes"
    newKey = relationship.key.underscore() + "_attributes"

    #Cria a chave do JSON com o nome tratado.
    json[newKey] = []

    #Serializa cada registro do hasMany e atribui ao array do JSON.
    records.forEach(
      (r) ->
        json[newKey].pushObject(r.serialize())
    )

    return json

  keyForRelationship: (key, relationship, method) ->

    if method != "serialize"

      if key == "produtos"
        return key

    @_super(key, relationship, method)


)

`export default TipoProdutoSerializer`
