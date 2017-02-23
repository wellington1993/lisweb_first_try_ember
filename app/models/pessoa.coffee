import DS from 'ember-data'

Pessoa = DS.Model.extend(

  tipoPessoa: DS.belongsTo("tipo-pessoa")

  nome: DS.attr("string")
  razaoSocial: DS.attr("string")
  rg: DS.attr("string")
  cpf: DS.attr("string")
  cnpj: DS.attr("string")
  inscricaoEstadual: DS.attr("string")
  contato: DS.attr("string")
  email: DS.attr("string")
  logradouro: DS.attr("string")
  numero: DS.attr("string")
  complemento: DS.attr("string")
  bairro: DS.attr("string")
  cidade: DS.attr("string")
  uf: DS.attr("string")
  cep: DS.attr("string")
  fax: DS.attr("string")
  telefone: DS.attr("string")
  celular: DS.attr("string")
  tipoLogradouro: DS.attr("string")
  codIbgeMunicipio: DS.attr("string")

)

export default Pessoa
