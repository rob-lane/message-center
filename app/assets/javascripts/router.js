// For more information see: http://emberjs.com/guides/routing/

MessageCenter.Router.map(function() {
  this.resource('messages', function() {
    this.route('new');
    this.route('edit', {path:'/messages/:message_id/edit'});
    this.route('destroy', {path: '/messages/:message_id/destroy'});
    this.route('forward', {path: '/messages/:message_id/forward'});
  });
  this.resource('message', { path: '/messages/:message_id'});
});
