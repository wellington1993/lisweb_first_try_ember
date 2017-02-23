import DS from 'ember-data'
import ApplicationSerializer from './application'

PessoaSerializer = ApplicationSerializer.extend(

  normalize: (typeClass, hash) ->
    return @avoidDirtyBelongsToOverride(@_super(typeClass, hash))

  avoidDirtyBelongsToOverride: (normalizedPayload) ->

    currentRecord = @get("store").peekRecord("pessoa", normalizedPayload.data.id)

    if currentRecord == null
      return normalizedPayload
    console.log(normalizedPayload)
    return normalizedPayload

)

export default PessoaSerializer
