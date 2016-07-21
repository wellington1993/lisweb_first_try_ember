import Devise from 'ember-simple-auth/authenticators/devise';

export default Devise.extend({
  serverTokenEndpoint: 'http://localhost:3000/users/sign_in'
  //não precisa da linha acima por que já fazemos o proxy
});
