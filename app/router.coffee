import Ember from 'ember'
import config from './config/environment'

Router = Ember.Router.extend(
  location: config.locationType,
  rootURL: config.rootURL
)

Router.map( ->

  @route('marcas')
  @route('cadastrar-marca')
  @route('laboratorios')
  @route('login')
  @route('dashboard')
  @route('nao-autorizado')
  @route('pagina-nao-encontrada', { path: '/*path' });

)

export default Router
