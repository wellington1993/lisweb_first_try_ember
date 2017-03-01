import DS from 'ember-data'
import ApplicationSerializer from './application'

PessoaSerializer = ApplicationSerializer.extend(

  serializeAttribute: (snapshot, json, key, attribute) ->

    #O atributo "sincronizado" é read-only.
    if key == "sincronizado"
      return

    return @_super(snapshot, json, key, attribute)

)

export default PessoaSerializer
