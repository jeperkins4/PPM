class PppamsReferencesController < ApplicationController
  before_filter :authenticate
  layout 'administration'
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @pppams_reference_pages, @pppams_references = paginate :pppams_references, :per_page => 1000, :order_by => 'name'
  end

  def show
    @pppams_reference = PppamsReference.find(params[:id])
  end

  def new
    @pppams_reference = PppamsReference.new
  end

  def create
    @pppams_reference = PppamsReference.new(params[:pppams_reference])
    if @pppams_reference.save
      flash[:notice] = 'PppamsReference was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @pppams_reference = PppamsReference.find(params[:id])
  end

  def update
    @pppams_reference = PppamsReference.find(params[:id])
    if @pppams_reference.update_attributes(params[:pppams_reference])
      flash[:notice] = 'PppamsReference was successfully updated.'
      redirect_to :action => 'show', :id => @pppams_reference
    else
      render :action => 'edit'
    end
  end

  def destroy
    PppamsReference.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
