class PppamsCategoryGroupsController < ApplicationController

  def index
    list
    render :action => 'list'
  end



  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @pppams_category_group_pages, @pppams_category_groups = paginate :pppams_category_groups, :per_page => 10
  end

  def show
    @pppams_category_group = PppamsCategoryGroup.find(params[:id])
  end

  def new
    @pppams_category_group = PppamsCategoryGroup.new
  end

  def create
    @pppams_category_group = PppamsCategoryGroup.new(params[:pppams_category_group])
    if @pppams_category_group.save
      flash[:notice] = 'PppamsCategoryGroup was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @pppams_category_group = PppamsCategoryGroup.find(params[:id])
  end

  def update
    @pppams_category_group = PppamsCategoryGroup.find(params[:id])
    if @pppams_category_group.update_attributes(params[:pppams_category_group])
      flash[:notice] = 'PppamsCategoryGroup was successfully updated.'
      redirect_to :action => 'show', :id => @pppams_category_group
    else
      render :action => 'edit'
    end
  end

  def destroy
    PppamsCategoryGroup.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
