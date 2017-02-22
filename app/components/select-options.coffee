import Ember from 'ember'

SelectOptionsComponent = Ember.Component.extend(

  tagName: "select"

  #Início - Atributos provenientes do contexto externo.

  #O conteúdo deste array devem ser objetos {title, value}
  arrayOpcoes: []

  #Action de retorno para quando um valor é selecionado.
  #Assinatura: (valor)
  actionOnChange: null

  #Fim

  didInsertElement: ->

    self = @

    #Insere uma opção em branco no select-options e deixa marcado como default.
    @$().prepend("<option></option>")
    @$().val("")

    #Atribui o listener.
    @$().change(
      ->
        valor = @value

        if valor == ""
          valor = null

        self.sendAction("actionOnChange", valor)
    )

)

export default SelectOptionsComponent
