import Ember from 'ember'
import config from './config/environment'

Router = Ember.Router.extend(
  location: config.locationType,
  rootURL: config.rootURL
)

Router.map( ->

  @route('marcas')
  @route('laboratorios')
  @route('login')
  @route('dashboard')

)

export default Router
