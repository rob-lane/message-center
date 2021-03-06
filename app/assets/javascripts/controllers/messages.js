MessageCenter.MessagesIndexController = Ember.ArrayController.extend({
  actions: {
    sort: function(sort_field) {
      this.set('sortProperties', [sort_field]);
      this.toggleProperty('sortAscending');
    }
  }
});
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
        if (self.get('validRecipients') === false) {
          self.model.set('errors.recipients', 'All recipients must be valid ')
        }
        alert('error: ' + reason);
      }

      function validRecipients() {
        recips = self.model.get('recipients').split(',');
        for (var i = 0; i < recips.length; i++) {
          if(!/\b\w+@[\w.]+\.[A-z.]{2,4}\b/.test(recips[i])) {
            self.set('validRecipients', false);
            return false;
          }
        }
        self.set('validRecipients', true);
        return true;
      }

      this.model.validate().then(function() {
        if (self.model.get('isValid') && validRecipients()) {
          self.model.save().then(transitionToMessage).catch(failure);
        }
      })
    },
    validRecipients: false,
    dirtyForm: false,
    serverError: null
  }
});
MessageCenter.MessagesEditController = Ember.ObjectController.extend({
  actions: {
    updateMessage: function() {
      var self = this;

      function transitionToMessage(message) {
        self.transitionToRoute('message', message);
      }

      this.model.validate().then(function() {
        if (self.model.get('isValid')) {
          self.model.save().then(transitionToMessage).catch(function(reason) {
            this.set('serverError', reason);
          });
        }
      });
    },
    cancelEdit: function() {
      this.transitionToRoute('messages');
    }
  }
});
MessageCenter.MessagesDestroyController = Ember.ObjectController.extend({
  actions: {
    cancel: function() {
      this.transitionToRoute('messages');
    },
    confirm: function() {
      this.model.destroyRecord();
      this.transitionToRoute('messages');
    }
  }
});
MessageCenter.MessagesForwardController = Ember.ObjectController.extend({
  actions: {
    cancel: function() {
      this.transitionToRoute('messages');
    },
    confirm: function() {
      var self = this;

      this.model.validate().then(function() {
        if (self.model.get('isValid')) {
          self.model.save().then(function() {
            self.model.reload();
            self.transitionToRoute('messages');
          });
        }
      });


    }
  },
  newRecipients: ""
});