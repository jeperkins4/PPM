class PppamsCategoriesController < ApplicationController
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
    @pppams_category_pages, @pppams_categories = paginate :pppams_categories, :conditions => ["facility_id = ?", session[:facility].id], :per_page => 100
  end

  def copy_categories
    if params[:choose_facility][:facility_id] != ""
      cat_count = ind_count = 0
      f_id = params[:choose_facility][:facility_id]
      new_f_id = session[:facility].id
      Facility.find(f_id).pppams_categories.each do |this_cat|
	 new_cat = this_cat.clone
	 new_cat.facility_id = new_f_id
        if new_cat.save
          cat_count.next 
          new_cat_id = new_cat.id
          this_cat.pppams_indicators.each do |this_ind|
            new_ind = this_ind.clone
	     new_ind.pppams_category_id = new_cat_id
            ind_count.next if new_ind.save
          end
        end
      end
      flash[:notice] = "Copying complete. #{cat_count} categories and #{ind_count} indicators processed"
    else
      flash[:notice] = 'An error occured during copying. Please try again!'
    end

    redirect_to(:action => 'index')
  end

  def show
    @pppams_category = PppamsCategory.find(params[:id])
    @pppams_indicator_pages, @pppams_indicators = paginate :pppams_indicators, :conditions => ["pppams_category_id = ?", params[:id]], :per_page => 10
    @list_output = render_to_string(:template => 'pppams_indicators/pure_list', :layout => false)
    @list_output = @list_output.gsub(/h1/, "h2")
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
  
  def export_as_csv
    @my_export = PppamsAsCsv.new
    @my_export.export_all
  end
end
