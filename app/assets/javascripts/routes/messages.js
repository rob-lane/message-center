MessageCenter.MessagesRoute = Ember.Route.extend({
  model: function() {
    return this.store.findAll('message');
  },
  setupController: function(controller, messages) {
    controller.set('model', messages);
  }
});
MessageCenter.MessagesNewRoute = Ember.Route.extend({
  model: function() {
    return this.store.createRecord('message');
  },
  setupController: function(controller, message) {
    controller.set('model', message);
  }
});