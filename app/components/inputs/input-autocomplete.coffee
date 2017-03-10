`import Ember from 'ember'`

InputsInputAutocompleteComponent = Ember.Component.extend(

  layoutName: 'ember/templates/components/inputs/input-autocomplete'
  showingSuggestions: false
  showingLoading: false
  showingMinLetters: true
  textValue: ''
  to: null #variable to hold timeout information
  currentAjax: null #variable to hold the current Ajax call
  timeout: 500
  minLetters: 3
  nothingFound: false
  suggestions: Ember.ArrayProxy.create({ content: Ember.A([]) })
  modelName: ''
  suggestionField: 'nome_empresa'
  suggestionTemplate: 'components/partials/input-autocomplete/suggestion'
  loadingTemplate: 'components/partials/input-autocomplete/loading'
  nothingFoundTemplate: 'components/partials/input-autocomplete/nothing-found'
  newRecordTemplate: 'components/partials/input-autocomplete/new-record'
  selectedItem: null
  selectedRecord: null
  preSelectedIndex: -1 #holds the item selected by the arrows
  showNewLink: false
  hasErrors: false
  placeholder: "Comece a digitar para buscar"
  constraints: null #string, comma-separated constraints (ex: 'transporte,alimentacao' )
  classNames: ['input-autocomplete']
  searchModalAction: null #if received as parameter, shows search button that calls this action
  onSelect: null
  onDeselect: null
  refIndex: null

  store: Ember.inject.service()

  _register: (->
    @set('componentReference', @)
  ).on('init')

  setFocus: ->
    if @$('.autocomplete-input')
      @$('.autocomplete-input').focus()

  #Helper getters and setters
  getSuggestionsArray: ->
    @get('suggestions').get('content')

  showNothingFound: ( ->
    @get('nothingFound') and (!@get('showingLoading') and (!@get("showingMinLetters")))
  ).property('nothingFound', 'showingLoading', 'showingMinLetters')

  lettersRemaining: ( ->
    @get('minLetters') - @get('textValue').length
  ).property('textValue')

  filled: (->
    @get('selectedRecord') || @get('selectedItem')
  ).property('selectedRecord', 'selectedItem')

  selectedRecordObserver: (->
    record = @get('selectedRecord')
    if record
      r = record
      i = {id: r.get('id')}
      i[@get('suggestionField')] = r.get(@get('suggestionField').camelize())
      @setSelectedItem(i,true)
    else
      @clearSelected(true)
  ).observes('selectedRecord').on('init')

  didReceiveAttrs: (args) ->
    @_super(args)
    @prepareInitialRecord()

  prepareInitialRecord: ->

    self = @

    record = @get("initialRecord")

    if !record
      return

    if !record.get("isLoaded")

      id = record.get("id")

      if !id
        return

      @get("store").findRecord(@get("modelName"), record.get("id")).then(
        (r) ->
          self.set("selectedRecord", r)
        (e) ->
      )
    else
      @set("selectedRecord", record)

  showLoading: () ->
    unless @get("showingLoading")
      @set('showingLoading', true)
      @showSuggestions()

  clearSuggestions: () ->
    @get('suggestions').clear()
    @set('showingLoading', false)

  showSuggestions: () ->
    @set('showingSuggestions', true)

  hideSuggestions: () ->
    @clearSuggestions()
    @set('showingSuggestions', false)

  #Maneja a digitação no componente, inicia busca de sugestões quando aplicável
  valueObserver: (() ->
    unless @get('filled')
      Ember.run.cancel(@get("to"))
      @set("to", null)
      if @get('textValue') == ''
        @cancelCurrentAjax()
        #@hideSuggestions()
      else
        @showSuggestions()
        if @get('textValue').length < @get('minLetters')
          @get('suggestions').clear()
          @set('showingMinLetters', true)
        else
          @set('showingMinLetters', false)

          @set("to",
            Ember.run.later(@get("searchSuggestions").bind(@), @get('timeout'))
          )

  ).observes('textValue')

  #----AJAX HANDLING
  searchSuggestions: () ->
    s=@
    @cancelCurrentAjax()
    ajaxUrl = "/s?m=#{s.get('modelName')}&q=#{s.get('textValue')}"
    if @get("constraints")?
      ajaxUrl += '&c=' + @get("constraints")

    adapter = @get("store").adapterFor("application")

    ajaxUrl = adapter.get("host") + "/" + ajaxUrl

    @set("currentAjax",

      $.ajax(
        url: ajaxUrl
        global: false
        headers: adapter.headersForRequest()
        beforeSend: (xhr) ->
          s.handleAjaxBeforeSend(xhr)

        success: (data, textStatus, jqXHR) ->
          s.handleAjaxDone(data)

        error: (jqXHR, textStatus, errorThrown) ->

      )
    )

  cancelCurrentAjax: () ->
    if (@get("currentAjax") != null)
      @get("currentAjax").abort()
      @set("currentAjax", null)

  handleAjaxBeforeSend: (xhr) ->
    @showLoading()

  handleAjaxDone: (data) ->
    @set("currentAjax", null)
    @showSuggestions()
    @set('preSelectedIndex', -1)
    if data.suggestions.length > 0
      key = @get("modelName").pluralize()
      payload = {}
      payload[key] = data.suggestions
      @get("store").pushPayload(payload)
      @handleSuggestions(data.suggestions)
    else
      @handleNoSuggestions()

    if @$('.autocomplete-input:focus').length == 0 #focus is not at the input
      if data.suggestions.length == 1 #select the value automatically
        @selectFirstSuggestion()
        return
      else #just focus in input
        @$('.autocomplete-input').focus()
        #console.log('focus on autocomplete')

  handleNoSuggestions: () ->
    @set('nothingFound', true)
    @clearSuggestions()

  handleSuggestions: (recs) ->
    s = @
    @clearSuggestions()
    @set('nothingFound', false)
    $.each(recs, (index, value) ->
      if s.get('suggestionField') != ''
        text = value[s.get('suggestionField')]
        highlightedText = s.highlight(text, s.get('textValue'))
        value.suggestionDescription = highlightedText
        value.ps = false
      s.get('suggestions').pushObject(value)
    )

  clearSelectedRunning: false,
  clearSelected: (silent) ->
    return if @get('clearSelectedRunning')
    @set('clearSelectedRunning',true)
    @set('selectedRecord', null)
    @set('selectedItem', null)
    @set('textValue', '')
    if silent
      @set('showingSuggestions', false)
      @set('showingMinLetters', false)
    else
      @set('showingSuggestions', true)
      @set('showingMinLetters', true)
      if @$('.autocomplete-input')
        @$('.autocomplete-input').focus()
      @$('.autocomplete-input').focus()
    @set('clearSelectedRunning',false)

  onSelectedRecordChange: (->

    selectedRecord = @get('selectedRecord')

    if selectedRecord == null
      @clearSelected()
      @sendAction('onDeselect', record: null, refIndex: @get("refIndex"))
    else
      @sendAction('onSelect', record: selectedRecord, refIndex: @get("refIndex"))
  ).observes('selectedRecord')

  #CONTROLE DO FOCO NO COMPONENTE
  focusIn: (event, view)->
    unless @get('selectedRecord')
      @set('showingSuggestions', true)
      @set('showingMinLetters', @get('lettersRemaining') > 0)

  lostFocus: (->
      Em.run.later(this, (->
        focussedElement = document.activeElement
        isFocussedOut = @$().has(focussedElement).length == 0 && !@$().is(focussedElement)
        if(isFocussedOut)
          hideSuggestionsCallback = ->

            try
              @set('showingSuggestions', false)
            catch e

          #suggestions are hiding before a click in the selection is detected
          setTimeout(hideSuggestionsCallback.bind(@),150)
          if !@get('selectedRecord')
            @selectPreSelected()
      ), 0);
  ).on('focusOut')

  #CONTROLE DA PRÉ-SELEÇÃO
  #O item pré-selecionado é o item que possui o foco
  #ou pelas setas do teclado ou pelo mouse, mas ainda não está selecionado
  keyDown: (event, view)->
    if @get('showingSuggestions')
      if (event.keyCode == 38)
        @selectUp()
      if (event.keyCode == 40)
        @selectDown()
      if (event.keyCode == 13)
        @selectPreSelected()
      if (event.keyCode == 27)
        @set('textValue', '')
    if @get('selectedRecord')
      if (event.keyCode == 8)
        @clearSelected()
      else
        event.stopPropagation()
        return false

  selectPreSelected: ->
    preSelectedIndex = @get('preSelectedIndex')
    if preSelectedIndex != -1
      s = @getSuggestionsArray()
      item = s[preSelectedIndex]
      @setSelectedItem(item)
    #if there is only one result, consider it as pre-selected
    else if @get('suggestions.length') == 1
      @selectFirstSuggestion()

  selectFirstSuggestion: ->
    suggestions = @get('suggestions')
    @setSelectedItem(suggestions.objectAt(0),true)

  clearPreSelection: ->
    if @get('preSelectedIndex') >= 0
      s = @getSuggestionsArray()
      item = s[@get('preSelectedIndex')]
      Ember.set(item, 'ps', false)

  preSelecionObserver: (->
    if @get('preSelectedIndex') >= 0
      s = @getSuggestionsArray()
      item = s[@get('preSelectedIndex')]
      Ember.set(item, 'ps', true)
  ).observes('preSelectedIndex')

  selectUp: ->
    if @get('preSelectedIndex') > 0
      @clearPreSelection()
      @set('preSelectedIndex', @get('preSelectedIndex')-1)

  selectDown: ->
    if @get('preSelectedIndex') < (@get('suggestions').content.length-1)
      @clearPreSelection()
      @set('preSelectedIndex', @get('preSelectedIndex')+1)

  #----MANEJO DO ITEM SELECIONADO
  selectedItemObserver: (->
    s=@get('store')
    that=@
    #@$('.autocomplete-input').prop('readOnly', @get('selectedItem') != null)
    if @get('selectedItem') and @get('selectedItem').id
      rec = s.peekRecord(@get('modelName'), @get('selectedItem').id)
      that.set('selectedRecord', rec)
    else
      that.set('selectedRecord', null)
  ).observes('selectedItem')

  setSelectedItem: (item,silent)->
    @set('selectedItem', item)
    @set('textValue', item[@get('suggestionField')] || "")
    @$('.autocomplete-input').focus() unless silent
    @hideSuggestions()


  #----TEXT Decorating
  highlight: (text, toHighlight)->
    textUpper = text.toUpperCase()
    toHighlightUpper = toHighlight.toUpperCase()
    index = textUpper.indexOf(toHighlightUpper)
    res = text
    if index >= 0
      res = text.substring(0,index) +
            "<span class='highlight'>" +
            text.substring(index,index+toHighlight.length) +
            "</span>" +
            text.substring(index + toHighlight.length)
    res

  #Actions available to the templates
  actions: {
    clearPreSelected: ->
      @clearPreSelection()

    selectItem: (item) ->
      @setSelectedItem(item)

    clearSelection: ->
      @clearSelected()

    openSearchModal: (evt) ->
      @sendAction("searchModalAction")
  }

)

`export default InputsInputAutocompleteComponent`
