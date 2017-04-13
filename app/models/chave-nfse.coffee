import DS from 'ember-data'

ChaveNfse = DS.Model.extend(

  chave: DS.attr("string")
  valor: DS.attr("string")

)

export default ChaveNfse
