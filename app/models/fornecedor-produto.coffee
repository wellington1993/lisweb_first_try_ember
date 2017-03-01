import DS from 'ember-data'

FornecedorProduto = DS.Model.extend(

  pessoa: DS.belongsTo("pessoa")
  produto: DS.belongsTo("produto")

  codigo: DS.attr("string")
  observacao: DS.attr("string")

)

export default FornecedorProduto
