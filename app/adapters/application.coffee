import DS from 'ember-data'
import ENV from '../config/environment'

ApplicationAdapter = DS.RESTAdapter.extend(

  #O host do adapter é definido no arquivo /config/environment.js.
  host: ENV.host

)

export default ApplicationAdapter
