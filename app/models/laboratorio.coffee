import DS from 'ember-data'
import GenericModel from './generic-model'

Laboratorio = GenericModel.extend(
  nome: DS.attr("string")
)

export default Laboratorio
