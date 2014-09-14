// For more information see: http://emberjs.com/guides/routing/

MessageCenter.Router.map(function() {
  this.resource('messages', function() {
    this.route('new')
  });
  this.resource('message', { path: '/messages/:message_id'});
});
