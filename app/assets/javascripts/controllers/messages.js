MessageCenter.MessagesNewController = Ember.ObjectController.extend({
  actions: {
    createMessage: function() {
      var self = this;

      self.set('dirtyForm', true);

      function transitionToMessage(message) {
        self.transitionToRoute('message', message);
      }

      function failure(reason) {
        this.set('serverError', reason)
        alert('error: ' + reason);
      }

      this.model.validate().then(function() {
        if (self.model.get('isValid')) {
          self.model.save().then(transitionToMessage).catch(failure);
        }
      })
    },
    dirtyForm: false,
    serverError: null
  }

});