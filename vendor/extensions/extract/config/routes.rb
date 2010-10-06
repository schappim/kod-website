ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.extract '/pages/:id/extract.:format', :controller => 'extract_pages', :action => 'index'
  end
end