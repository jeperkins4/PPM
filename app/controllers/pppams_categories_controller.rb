class PppamsCategoriesController < ApplicationController
  before_filter :admin_authenticate
  layout 'administration'
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }
         


  def list
    @pppams_category_pages, @pppams_categories = paginate :pppams_categories, :conditions => ["facility_id = ?", session[:facility].id], :per_page => 10
  end

  def show
    @pppams_indicator_pages, @pppams_indicators = paginate :pppams_indicators, :conditions => ["pppams_category_id = ?", params[:id]], :per_page => 10
    @list_output = render_to_string(:template => 'pppams_indicators/list', :layout => false)
    @list_output = @list_output.gsub(/h1/, "h2")
    @pppams_category = PppamsCategory.find(params[:id])
  end

  def new
    @pppams_category = PppamsCategory.new
  end

  def create
    @pppams_category = PppamsCategory.new(params[:pppams_category])
    @pppams_category.facility_id = session[:facility].id
    if @pppams_category.save
      flash[:notice] = 'PppamsCategory was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @pppams_category = PppamsCategory.find(params[:id])
  end

  def update
    @pppams_category = PppamsCategory.find(params[:id])
    if @pppams_category.update_attributes(params[:pppams_category])
      flash[:notice] = 'PppamsCategory was successfully updated.'
      redirect_to :action => 'show', :id => @pppams_category
    else
      render :action => 'edit'
    end
  end

  def destroy
    PppamsCategory.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
