class PppamsCategoryBaseRefsController < ApplicationController

  def index
    list
    render :action => 'list'
  end



  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @pppams_category_base_ref_pages, @pppams_category_base_refs = paginate :pppams_category_base_refs, :per_page => 10
  end

  def show
    @pppams_category_base_ref = PppamsCategoryBaseRef.find(params[:id])
  end

  def new
    @pppams_category_base_ref = PppamsCategoryBaseRef.new
  end

  def create
    @pppams_category_base_ref = PppamsCategoryBaseRef.new(params[:pppams_category_base_ref])
    if @pppams_category_base_ref.save
      flash[:notice] = 'PppamsCategoryBaseRef was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @pppams_category_base_ref = PppamsCategoryBaseRef.find(params[:id])
  end

  def update
    @pppams_category_base_ref = PppamsCategoryBaseRef.find(params[:id])
    if @pppams_category_base_ref.update_attributes(params[:pppams_category_base_ref])
      flash[:notice] = 'PppamsCategoryBaseRef was successfully updated.'
      redirect_to :action => 'show', :id => @pppams_category_base_ref
    else
      render :action => 'edit'
    end
  end

  def destroy
    PppamsCategoryBaseRef.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
