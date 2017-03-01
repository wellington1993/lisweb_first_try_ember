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

  @route("pagina-nao-encontrada", { path: "/*path" })

)

export default Router
