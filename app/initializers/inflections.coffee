# Takes two parameters: container and application
initialize = () ->
  # application.register 'route', 'foo', 'service:foo'

InflectionsInitializer =
  name: 'inflections'
  initialize: ->

    inflector = Ember.Inflector.inflector
    inflector.irregular("tipo-pessoa", "tipos-pessoa")


export {initialize}
export default InflectionsInitializer
