class Admin::ExtractsController < Admin::PagesController
  paginate_models
  
  def index
    options = pagination_parameters.merge({
      :order      => 'virtual ASC, status_id ASC, published_at DESC, id DESC',
      :conditions => params[:search] ? ['LOWER(title) LIKE ?', "%#{params[:search].downcase}%"] : nil
    })
    
    @page     = Page.find_by_id(params[:page_id])
    @children = @page.children.paginate(options)
    
    response_for :plural
  end
end