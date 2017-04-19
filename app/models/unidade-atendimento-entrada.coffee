import DS from 'ember-data'

UnidadeAtendimentoEntrada = DS.Model.extend(

  nome: DS.attr("string")
  grupoParametroNFSe: DS.belongsTo("grupo-parametro-nfse")

)

export default UnidadeAtendimentoEntrada
