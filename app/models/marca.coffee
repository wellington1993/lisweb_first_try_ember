import DS from 'ember-data'
import GenericModel from './generic-model'

Marca = GenericModel.extend(

  nome: DS.attr("string")
  descricao: DS.attr("string")

)

export default Marca
