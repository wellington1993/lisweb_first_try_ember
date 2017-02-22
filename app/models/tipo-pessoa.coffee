import DS from 'ember-data'

TipoPessoa = DS.Model.extend(
  nome: DS.attr("string")
  tipo: DS.attr("string")
)

export default TipoPessoa
