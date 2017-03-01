import DS from 'ember-data'

UnidadeMedidaEntrada = DS.Model.extend(

  produto: DS.belongsTo("produto")
  unidadeMedida: DS.belongsTo("unidade-medida")

  quantidade: DS.attr("number")
  ordem: DS.attr("number")

)

export default UnidadeMedidaEntrada
