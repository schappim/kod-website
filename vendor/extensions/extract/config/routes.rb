ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resources :extracts do |page|
      page.resources :children, :controller => "pages",    :path_prefix => "/admin/extracts/:page_id", :except => [:index]
      page.resources :children, :controller => "extracts", :path_prefix => "/admin/extracts/:page_id", :only => [:index]
    end    
  end
end