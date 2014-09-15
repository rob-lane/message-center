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
MessageCenter.MessagesEditRoute = Ember.Route.extend({
  model: function(params) {
    return this.store.find('message', params.message_id);
  }
});