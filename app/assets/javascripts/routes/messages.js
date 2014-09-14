// New message route
MessageCenter.MessagesNewRoute = Ember.Route.extend({
  model: function() {
    return this.store.createRecord('message')
  },
  setupController: function(controller, message) {
    controller.set('model', message);
  }
});