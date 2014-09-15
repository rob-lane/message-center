MessageCenter.Message = DS.Model.extend(Ember.Validations.Mixin, {
  subject: DS.attr('string'),
  body: DS.attr('string'),
  created_at: DS.attr('string'),
  updated_at: DS.attr('string'),
  recipients: DS.attr('list'),
  new_recipients: DS.attr('list'),
  link_count: DS.attr('number'),
  validations: {
    recipients: {
      format: {
        with: /\b\w+@[\w.]+\.[A-z.]{2,4}\b/,
        message: 'Must be a valid email address, seperate multiple emails with a comma'
      }
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
    deserialized = deserialized || '';
    return deserialized.split(',');
  }
});