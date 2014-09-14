// For more information see: http://emberjs.com/guides/routing/

MessageCenter.Router.map(function() {
  this.resource('messages');
  this.resource('message', { path: '/messages/:message_id'});
});
