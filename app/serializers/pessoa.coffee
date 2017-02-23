import DS from 'ember-data'
import ApplicationSerializer from './application'

PessoaSerializer = ApplicationSerializer.extend(

  normalize: (typeClass, hash) ->
    return @avoidDirtyBelongsToOverride(@_super(typeClass, hash))

  avoidDirtyBelongsToOverride: (normalizedPayload) ->

    self = @

    currentRecord = @get("store").peekRecord("pessoa", normalizedPayload.data.id)

    if currentRecord == null || !currentRecord.get("hasDirtyAttributes")
      return normalizedPayload

    Object.keys(normalizedPayload.data.relationships).forEach(
      (relationshipName) ->

        currentId = currentRecord.get(relationshipName + ".id")
        refreshedId = normalizedPayload.data.relationships[relationshipName].data.id

        if parseInt(currentId) != parseInt(refreshedId)
          delete normalizedPayload.data.relationships[relationshipName]
    )

    return normalizedPayload

)

export default PessoaSerializer
