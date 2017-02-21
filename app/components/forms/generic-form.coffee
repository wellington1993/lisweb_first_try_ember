import Ember from 'ember'
import UtilsComponentsBootstrapBoxAlertMixin from '../../mixins/utils/components/bootstrap/box-alert'

FormsGenericFormComponent = Ember.Component.extend(UtilsComponentsBootstrapBoxAlertMixin,

  tagName: "form"

  messageBox: null

  #(params, callbackOnAjaxComplete[success, data])
  actionOnSubmit: null

  actionOnSubmitted: null

  didInsertElement: ->
    @mapSelectors()

  mapSelectors: ->
    @set("messageBox", @$(".alert"))

  #Classes que herdarem devem implementar este método.
  #O callback deve retornar nos parâmetros true ou false indicando se o formulário
  #é válido (true -> válido, false -> inválido);
  validate: (callbackAfterValidate) ->
    return callbackAfterValidate(true)

  #Método para sobreescrever o comportamento padrão do form HTML..
  submit: (e) ->

    self = @

    #Evita o submit default HTML.
    e.preventDefault()

    #Realiza a validação do formulário.
    @validate(

      (valido) ->

        #Se o formulário é válido o método final de submissão é chamado.
        if valido

          self.preSubmit(
            ->

              self.submitForm(

                (sucesso) ->

                  self.posSubmit()

              )
          )


    )

  #Método final para submeter o formulário após todas as validações.
  #As classes que herdarem devem implementar este método.
  submitForm: ->
    @sendAction("actionOnSubmit", {})
    return true

  mostrarMensagem: (options, callbackOnAnimationComplete) ->
    @showMessage(@get("messageBox"), options, callbackOnAnimationComplete)

  esconderMensagem: (options, callbackOnAnimationComplete) ->
    @hideMessage(@get("messageBox"), {}, callbackOnAnimationComplete)

  preSubmit: (callbackOnAnimationComplete = ->) ->
    @$(":submit").attr("disabled", true)
    callbackOnAnimationComplete()

  posSubmit: (callbackOnAnimationComplete = ->) ->
    @$(":submit").attr("disabled", false)
    callbackOnAnimationComplete()

)

export default FormsGenericFormComponent
