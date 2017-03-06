import Ember from "ember"
import config from "./config/environment"

Router = Ember.Router.extend(
  location: config.locationType,
  rootURL: config.rootURL
)

Router.map( ->

  @route("cadastrar-categoria-de-produto")
  @route("cadastrar-marca")
  @route("cadastrar-pessoa")
  @route("cadastrar-tipo-de-pessoa")
  @route("cadastrar-tipo-de-produto")
  @route("cadastrar-unidade-de-medida")
  @route("categorias-de-produto")
  @route("laboratorios")
  @route("login")
  @route("marcas")
  @route("nao-autorizado")
  @route("pessoas")
  @route("pessoas.show", path: "/pessoas/:pessoa_id")
  @route("tipos-de-pessoa")
  @route("tipos-de-produto")
  @route("unidades-de-medida")

  @route("categorias-de-produto.show", path: "/categorias-de-produto/:categoria_produto_id")
  @route("marcas.show", path: "/marcas/:marca_id")
  @route("tipos-de-pessoa.show", path: "/tipos-de-pessoa/:tipo_pessoa_id")
  @route("tipos-de-produto.show", path: "/tipos-de-produto/:tipo_produto_id")
  @route("unidades-de-medida.show", path: "/unidades-de-medida/:unidade_medida_id")

  @route("pagina-nao-encontrada", { path: "/*path" })

)

export default Router
