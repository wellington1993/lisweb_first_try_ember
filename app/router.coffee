import Ember from "ember"
import config from "./config/environment"

Router = Ember.Router.extend(
  location: config.locationType,
  rootURL: config.rootURL
)

Router.map( ->

  #Rotas para categorias de produto.
  @route("categorias-de-produto/new")
  @route("categorias-de-produto/show", path: "/categorias-de-produto/:categoria_produto_id")
  @route("categorias-de-produto/index", path: "/categorias-de-produto")

  #Rotas para marcas.
  @route("marcas/new")
  @route("marcas/show", path: "/marcas/:marca_id")
  @route("marcas/index", path: "/marcas")

  #Rotas para pessoas.
  @route("pessoas/new")
  @route("pessoas/show", path: "/pessoas/:pessoa_id")
  @route("pessoas/index", path: "/pessoas")

  #Rotas para tipos de pessoas.
  @route("tipos-de-pessoa/new")
  @route("tipos-de-pessoa/show", path: "/tipos-de-pessoa/:tipo_pessoa_id")
  @route("tipos-de-pessoa/index", path: "/tipos-de-pessoa")

  #Rotas para tipos de produto.
  @route("tipos-de-produto/new")
  @route("tipos-de-produto/show", path: "/tipos-de-produto/:tipo_produto_id")
  @route("tipos-de-produto/index", path: "/tipos-de-produto")

  #Rotas para unidades de medida.
  @route("unidades-de-medida/new")
  @route("unidades-de-medida/show", path: "/unidades-de-medida/:unidade_medida_id")
  @route("unidades-de-medida/index", path: "/unidades-de-medida")

  @route("laboratorios")
  @route("login")

  @route("nao-autorizado")
  @route("pagina-nao-encontrada", { path: "/*path" })

)

export default Router
