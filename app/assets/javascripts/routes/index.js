MessageCenter.IndexRoute = Ember.Route.extend({
  beforeModel: function() {
    this.transitionTo('messages');
  }
});