import Ember from 'ember'
import UtilsComponentsFormMixin from '../../mixins/utils/components/form'

FormsGenericFormComponent = Ember.Component.extend(

  tagName: "form"

  #(params, callbackOnAjaxComplete[sucesso, dados])
  actionOnSubmeterFormulario: null
  actionOnFormularioSubmetido: null

  #Classes que herdarem devem implementar este método.
  #O callback deve retornar nos parâmetros true ou false indicando se o formulário
  #é válido (true -> válido, false -> inválido);
  validarFormulario: (callbackOnValidacaoCompleta) ->
    return callbackOnValidacaoCompleta(true)

  #Método para sobreescrever o comportamento padrão do form HTML..
  submit: (e) ->

    self = @

    #Evita o submit default HTML.
    e.preventDefault()

    #Realiza a validação do formulário.
    @validarFormulario(

      (valido) ->

        #Se o formulário é válido o método final de submissão é chamado.
        if valido
          self.submeterFormulario()

    )

  #Método final para submeter o formulário após todas as validações.
  #As classes que herdarem devem implementar este método.
  submeterFormulario: ->
    @sendAction("actionOnFormularioSubmetido", {})
    return true


)

export default FormsGenericFormComponent
