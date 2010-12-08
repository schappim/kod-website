class DefaultPagePartsExtension < Radiant::Extension
  version "0.3"
  description "Enables auto-creation of default page parts for a page's children"
  url "http://github.com/ckirby/radiant-default-page-parts-extension"
  
  Admin::PagesController.class_eval do
    alias :original_new :new
    
    def new
      unless params[:page_id].blank?
        parent_page = Page.find(params[:page_id]);
        child_parts = parent_page.render_part("page_part_config")
        self.model = model_class.new_with_page_parts(config, child_parts)
      else
        self.model = model_class.new_with_defaults(config)
        self.model.slug = '/'
      end
      response_for :singular
    end
  end
  
  class << Page
    def new_with_page_parts(config = Radiant::Config, parts = String)
      begin
        unless parts.empty?
          config = YAML::load(parts)
          if config.is_a?(Array) && config.size > 0
            page = new
            config.each do |part|
              default_filter = part['filter'].to_s.camelize
              filter = ["SmartyPants", "Markdown", "Textile", "WymEditor"].include?(default_filter) ? "#{default_filter}" : ""
              name = part['name']
              page.parts << PagePart.new(:name => name, :filter_id => filter)
            end
            page
          end
        else
          new_with_defaults(config)
        end
      rescue
        new_with_defaults(config)
      end
    end
  end
end