module Extract
  module ResourceControllerExt
    def self.included(base)
      base.class_eval {
        protected
        
        def continue_url_with_extract(options)
          if defined?(model.parent) && model.parent && model.parent.is_extract?
            options[:redirect_to] || (params[:continue] ? edit_admin_extract_child_url(model.parent, model) : index_page_for_model_with_extract)
          else
            continue_url_without_extract(options)
          end
        end
        alias_method_chain :continue_url, :extract

        def index_page_for_model_with_extract
          parts = {:controller => "extracts", :action => "index", :page_id => model.parent}          
          i = model.parent.children.sort_by(&:published_at).reverse.index(model)
          p = (i / pagination_parameters[:per_page].to_i) + 1
          parts[:p] = p if p && p > 1
          parts
        end
      }
    end
  end
end