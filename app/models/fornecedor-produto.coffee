import DS from 'ember-data'

FornecedorProduto = DS.Model.extend(

  fornecedor: DS.belongsTo("pessoa")
  produto: DS.belongsTo("produto")

  codigo: DS.attr("string")
  observacao: DS.attr("string")

)

export default FornecedorProduto
