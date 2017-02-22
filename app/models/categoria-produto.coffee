import DS from 'ember-data'

CategoriaProduto = DS.Model.extend(

  nome: DS.attr("string")
  descricao: DS.attr("string")

)

export default CategoriaProduto
