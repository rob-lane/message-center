MessageCenter.MessagesNewController = Ember.ObjectController.extend({
  actions: {
    createMessage: function() {
      var self = this;

      function transitionToMessage(message) {
        self.transitionToRoute('message', message);
      }

      function failure(reason) {
        alert('error: ' + reason);
      }

      this.model.save().then(transitionToMessage).catch(failure);
    }
  }
});