import DS from 'ember-data'

ChaveNfseEntrada = DS.Model.extend(

  chave: DS.attr("string")
  valor: DS.attr("string")

)

export default ChaveNfseEntrada
