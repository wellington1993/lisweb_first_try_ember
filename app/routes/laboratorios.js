import Ember from 'ember';

export default Ember.Route.extend({
  model: function() {
    //var r = this.get('store').createRecord('marca',
    //  {nome: 'Marca criada pelo emberdata'});
    //r.save();
    return this.get('store').findAll('laboratorio');
  }
});
