class PppamsIndicatorBaseRefsController < ApplicationController

  def index
    list
    render :action => 'list'
  end



  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @pppams_indicator_base_ref_pages, @pppams_indicator_base_refs = paginate :pppams_indicator_base_refs, :per_page => 10
  end

  def show
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.find(params[:id])
  end

  def new
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.new
  end

  def create
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.new(params[:pppams_indicator_base_ref])
    if @pppams_indicator_base_ref.save
      flash[:notice] = 'PppamsIndicatorBaseRef was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.find(params[:id])
  end

  def update
    @pppams_indicator_base_ref = PppamsIndicatorBaseRef.find(params[:id])
    if @pppams_indicator_base_ref.update_attributes(params[:pppams_indicator_base_ref])
      flash[:notice] = 'PppamsIndicatorBaseRef was successfully updated.'
      redirect_to :action => 'show', :id => @pppams_indicator_base_ref
    else
      render :action => 'edit'
    end
  end

  def destroy
    PppamsIndicatorBaseRef.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
