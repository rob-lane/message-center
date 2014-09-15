// For more information see: http://emberjs.com/guides/routing/

MessageCenter.Router.map(function() {
  this.resource('messages', function() {
    this.route('new');
    this.route('edit', {path:'/:message_id/edit'});
    this.route('destroy', {path: '/:message_id/destroy'});
    this.route('forward', {path: '/:message_id/forward'});
  });
  this.resource('message', { path: '/message/:message_id'});
});
