MessageCenter.ApplicationStore = DS.Store.extend({

});

// Override the default adapter with the `DS.ActiveModelAdapter` which
// is built to work nicely with the ActiveModel::Serializers gem.
MessageCenter.ApplicationAdapter = DS.ActiveModelAdapter.extend({
  namespace: 'api/v1',
  headers: Ember.computed(function(){
    return {"X-CSRF-Token": $('meta[name="csrf-token"]').attr('content')}
  })
});