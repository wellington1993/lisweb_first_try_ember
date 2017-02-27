import DS from 'ember-data'

Produto = DS.Model.extend(

  unidadesMedidaEntrada: DS.hasMany("unidade-medida-entrada")
  fornecedores: DS.hasMany("fornecedor-produto")

  nome: DS.attr("string")
  descricao: DS.attr("string")

)

export default Produto
