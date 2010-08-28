function set_filter_toolbar(select) {
  var textarea = select.up('div').down('textarea').readAttribute('id');
  var toolbar  = textarea + '_toolbar';
  var filter   = select.getValue();
        
  if (Control.TextArea.ToolBar[filter] != null) {
    remove();
    
    if (filter) {
      var tb = new Control.TextArea.ToolBar[filter](textarea, {
        assets:  typeof(Asset) != undefined ? true : false,
        preview: true
      });
      
      tb.toolbar.container.id = toolbar;
      
      // Allow for Papperclipped Asset Manager extension
      if (typeof(Asset) != undefined) {
        Event.addBehavior({ 'a.filter_image_button' : Asset.ShowBucket });
      };
    }    
  } else {
    remove();
  }
  
  function remove() {
    if ($(toolbar) != null) {
      $(toolbar).remove();
    }    
  }
}

document.observe('dom:loaded', function() {  
  $$('#pages select').each( function(el) {
    el.observe('change', function(e) {
      set_filter_toolbar(el);
    })
    
    set_filter_toolbar(el);
  });
});