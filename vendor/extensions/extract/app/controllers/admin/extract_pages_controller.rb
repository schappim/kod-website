class Admin::ExtractPagesController < Admin::PagesController
  paginate_models

  def index
    options = pagination_parameters.merge({
      :order      => 'virtual DESC, published_at DESC, id DESC',
      :conditions => {'parent_id' => params[:id]}
    })

    @parent = Page.find_by_id(params[:id])
    @pages  = Page.paginate(options)

    response_for :plural
  end
end