import DS from 'ember-data'

UnidadeMedida = DS.Model.extend(

  nome: DS.attr("string")
  descricao: DS.attr("string")
  sigla: DS.attr("string")

)

export default UnidadeMedida
