import Ember from 'ember'

FormsNewPessoaIdentificacaoComponent = Ember.Component.extend(

  store: Ember.inject.service()

  tiposPessoa: null

  arraySelectOptionsTipoPessoa: Ember.computed("tiposPessoa", ->

    tiposPessoa = @get("tiposPessoa")

    if !tiposPessoa
      return tiposPessoa

    arrayFinal = []

    tiposPessoa.forEach(
      (tipoPessoa) ->
        arrayFinal.push(title: tipoPessoa.get("nome"), value: tipoPessoa.get("id"))
    )

    return arrayFinal

  )

  actions:

    actEscolherComboTipoPessoa: (idTipoPessoa) ->
      tipoPessoa = @get("store").peekRecord("tipo-pessoa", idTipoPessoa)

      boxPf = @$("#dados-identificacao-pessoa-fisica")
      boxPj =@$("#dados-identificacao-pessoa-juridica")

      if tipoPessoa.get("tipo") == "PF"
        boxPj.hide()
        boxPf.show()
      else
        boxPf.hide()
        boxPj.show()

)

export default FormsNewPessoaIdentificacaoComponent
