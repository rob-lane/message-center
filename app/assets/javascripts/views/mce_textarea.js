MessageCenter.TinymceView = Ember.TextArea.extend({
  didInsertElement: function() {
    var view = this;
    var ele = "#" + this.get('elementId');
    tinymce.init({
      selector: ele,
      setup: function(editor) {
        view.set('editor', editor);
        editor.on('keyup change', function() {
          view.suspendValueChange(function() {
            view.set('value', editor.getContent());
          });
        });
      },
      plugins:['link']
    });
  },
  suspendValueChange : function(callback) {
    this._suspendValueChange = true;
    callback();
    this._suspendValueChange = false;
  },
  valueChanged : function() {
    if (this._suspendValueChange) { return; }
    this.get('editor').setContent(this.get('value'));
  }.observes("value"),
  willClearRender: function() {
    this.get('editor').remove();
  }
});