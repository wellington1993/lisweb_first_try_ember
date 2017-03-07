import DS from 'ember-data'

Produto = DS.Model.extend(

  tipoProduto: DS.belongsTo("tipo-produto")

  unidadesMedidaEntrada: DS.hasMany("unidade-medida-entrada")
  fornecedores: DS.hasMany("fornecedor-produto")
  marca: DS.belongsTo("marca")

  nome: DS.attr("string")
  descricao: DS.attr("string")
  modelo: DS.attr("string")
  status: DS.attr("string")

)

export default Produto
