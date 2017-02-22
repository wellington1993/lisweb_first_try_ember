import Ember from 'ember'
import config from './config/environment'

Router = Ember.Router.extend(
  location: config.locationType,
  rootURL: config.rootURL
)

Router.map( ->

  @route('marcas')
  @route('cadastrar-marca')

  @route('tipos-de-pessoa')
  @route('cadastrar-tipo-de-pessoa')
  @route('categorias-de-produto')
  @route('cadastrar-categoria-de-produto')
  @route('unidades-de-medida')
  @route('cadastrar-unidade-de-medida')

  @route('laboratorios')
  @route('login')
  @route('dashboard')
  @route('nao-autorizado')
  @route('pagina-nao-encontrada', { path: '/*path' });

)

export default Router
