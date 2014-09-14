MessageCenter.Message = DS.Model.extend(Ember.Validations.Mixin, {
  subject: DS.attr('string'),
  body: DS.attr('string'),
  created_at: DS.attr('string'),
  updated_at: DS.attr('string'),
  recipients: DS.attr('list'),
  validations: {
    recipients: {
      format: /\b\w+@[\w.]+\.[A-z.]{2,4}\b/
    },
    body: {
      presence: { message: 'A message body is required...' }
    }
  }
});

MessageCenter.ListTransform = DS.Transform.extend({
  deserialize: function(serialized) {
    return serialized.join(',');
  },
  serialize: function(deserialized) {
    return deserialized.split(',');
  }
});