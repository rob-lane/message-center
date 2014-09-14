MessageCenter.Message = DS.Model.extend(Ember.Validations.Mixin, {
  subject: DS.attr('string'),
  body: DS.attr('string'),
  created_at: DS.attr('string'),
  updated_at: DS.attr('string'),
  validations: {
    body: {
      presence: { message: 'A message body is required...' }
    }
  }
});