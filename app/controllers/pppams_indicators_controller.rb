class PppamsIndicatorsController < ApplicationController
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
    @pppams_indicator_pages, @pppams_indicators = paginate :pppams_indicators, :per_page => 10
  end

  def show
    @pppams_indicator = PppamsIndicator.find(params[:id])
  end

  def new
    @pppams_indicator = PppamsIndicator.new(:pppams_category_id => params[:pppams_category_id])
  end

  def create
    @pppams_indicator = PppamsIndicator.new(params[:pppams_indicator])
    if @pppams_indicator.save
      flash[:notice] = 'PppamsIndicator was successfully created.'
      redirect_to :controller => 'pppams_categories', :action => 'show', :id => @pppams_indicator.pppams_category_id
    else
      render :action => 'new'
    end
  end

  def edit
    @pppams_indicator = PppamsIndicator.find(params[:id])
  end

  def update
    @pppams_indicator = PppamsIndicator.find(params[:id])
    if @pppams_indicator.update_attributes(params[:pppams_indicator])
      flash[:notice] = 'PppamsIndicator was successfully updated.'
      redirect_to :action => 'show', :id => @pppams_indicator
    else
      render :action => 'edit'
    end
  end

  def destroy
    @thisIndicatorCat = PppamsIndicator.find(params[:id]).pppams_category_id
    PppamsIndicator.find(params[:id]).destroy
    redirect_to :action => 'show', :controller => 'pppams_categories', :id => @thisIndicatorCat
  end
end
