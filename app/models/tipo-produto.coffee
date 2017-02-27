import DS from 'ember-data'

TipoProduto = DS.Model.extend(

  produtos: DS.hasMany("produtos")

  nome: DS.attr("string")
  descricao: DS.attr("string")

)

export default TipoProduto
