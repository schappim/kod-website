class ExtractExtension < Radiant::Extension
  version "1.0"
  description "Extract a pages children into its own paginated tab within the admin"
  url "http://yourwebsite.com/extract"

  extension_config do |config|
    config.after_initialize do      
      unless Radiant::Config['admin.date_format']
        Radiant::Config['admin.date_format'] = '%d-%m-%Y'
      end
    end
  end

  def activate
    ExtractPage
    ExtractArchivePage
    
    admin.page.edit.add :form, "redirect"
    
    Radiant::AdminUI.class_eval do
      attr_accessor :extract_pages
    end
    admin.extract_pages = load_default_settings_regions

    set_tab
  end

  def set_tab
    pages = Page.find(:all, :order => "slug DESC", :conditions => ["class_name = ? OR class_name = ?", "ExtractPage", "ExtractArchivePage"])
    
    tab 'Content' do
      pages.each do |page|
        add_item page.title, "/admin/pages/#{page.id}/extract", :before => "Assets"
      end
    end if pages
  end
  
  def load_default_settings_regions
    returning OpenStruct.new do |settings|
      settings.index = Radiant::AdminUI::RegionSet.new do |index|
        index.top.concat %w{}
        index.sitemap_head.concat %w{title_column_header status_column_header published_on_column_header modify_column_header}
        index.node.concat %w{title_column status_column published_on_column modify_column}
        index.bottom.concat %w{}
      end
    end
  end
end


