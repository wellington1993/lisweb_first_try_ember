import DS from 'ember-data'

TipoProduto = DS.Model.extend(

  unidadeMedidaSaida: DS.belongsTo("unidade-medida")
  categoriaProduto: DS.belongsTo("categoria-produto")
  produtos: DS.hasMany("produto")

  mnemonico: DS.attr("string")
  nome: DS.attr("string")
  descricao: DS.attr("string")
  estoqueMinimo: DS.attr("number")
  estoqueIdeal: DS.attr("number")
  status: DS.attr("string")
  pontoCompra: DS.attr("number")


)

export default TipoProduto
