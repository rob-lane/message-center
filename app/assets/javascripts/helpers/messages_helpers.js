MessageCenter.DateHelper = Ember.Handlebars.helper('date', function(value, options) {
  var dateValue = new Date(value);
  var dateString = dateValue.toLocaleDateString() +" "+ dateValue.toLocaleTimeString();
  return new Ember.Handlebars.SafeString('<span class="date">' +dateString+ '</span>');
});