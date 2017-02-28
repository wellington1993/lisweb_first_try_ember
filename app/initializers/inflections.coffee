initialize = ->
  inflector = Ember.Inflector.inflector
  inflector.irregular("tipo-pessoa", "tipos-pessoa")
  inflector.irregular("categoria", "categorias")
  inflector.irregular("categoria-produto", "categorias-produto")
  inflector.irregular("unidade-medida", "unidades-medida")
  inflector.irregular("tipo-produto", "tipos-produto")
  inflector.irregular("unidade-medida-entrada", "unidades-medida-entrada")
  inflector.irregular("fornecedor-produto", "fornecedores-produtos")

InflectionsInitializer =
  name: 'inflections'
  initialize: initialize


`export {initialize}`
`export default InflectionsInitializer`
