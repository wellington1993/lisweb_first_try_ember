import DS from 'ember-data'

TipoPessoa = DS.Model.extend(
  nome: DS.attr("string")
  tipo: DS.attr("string")

  isPessoaFisica: Ember.computed("tipo", ->

    if @get("tipo") == "PF"
      return true

    return false

  )


)

export default TipoPessoa
