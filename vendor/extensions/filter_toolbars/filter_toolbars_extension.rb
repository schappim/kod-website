class FilterToolbarsExtension < Radiant::Extension
  version     "1.0"
  description "Adds a textile or markdown filter to admin textareas using Control.TextArea [http://livepipe.net/projects/control_textarea/]"
  url         "http://yourwebsite.com/filter_toolbars"
  
  def activate
    Admin::PagesController.class_eval do
      before_filter :include_assets
      
      def include_assets
        include_stylesheet 'admin/filter-toolbars'

        %w(
          admin/control.textarea 
          admin/control.textarea.textile 
          admin/control.textarea.markdown 
          admin/filter-toolbars).each { |e| include_javascript e }
      end
    end
  end
end
