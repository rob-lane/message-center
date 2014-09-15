MessageCenter.MessageRoute = Ember.Route.extend({
  model: function(params) {
    return this.store.find('message', params.message_id);
  },
  renderTemplate: function() {
    this.render('showMessage');
  }
});