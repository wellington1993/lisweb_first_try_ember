initialize = ->
  inflector = Ember.Inflector.inflector
  inflector.irregular("tipo-pessoa", "tipos-pessoa")
  inflector.irregular("categoria", "categorias")
  inflector.irregular("categoria-produto", "categorias-produto")

InflectionsInitializer =
  name: 'inflections'
  initialize: initialize


`export {initialize}`
`export default InflectionsInitializer`
