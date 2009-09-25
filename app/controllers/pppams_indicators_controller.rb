class PppamsIndicatorsController < ApplicationController
  before_filter :authenticate, :set_frequency_options
  layout 'administration'
  
 require 'rubygems'
 require 'orderedhash.rb'
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @pppams_indicators = PppamsIndicator.paginate :page => params[:page]
    session[:indicator_list_mode] = 'list'
  end

  def pure_list
    @pppams_indicators = PppamsIndicator.paginate :page => params[:page]
  end

  def editable_list
    @pppams_indicators = PppamsIndicator.paginate :page => params[:page]
    session[:indicator_list_mode] = 'editable_list'
    render :action => 'list'
  end
  
  def _to_do 
    render :partial => 'to_do', :locals => {:time => Time.parse(params[:time]) }
  end

  def _editable_to_do 
    render :partial => 'editable_to_do', :locals => {:time => Time.parse(params[:time]) }
  end

  def bulk_update
    params[:pppams_review_selector].each { |id|
      @pppams_review = PppamsReview.find(id)
      @pppams_review.status = params[:pppams_review_new_status]
      @pppams_review.notes = @pppams_review.notes.nil? ? params[:pppams_review_bulk_note] : @pppams_review.notes + "\r\n" + params[:pppams_review_bulk_note]
      @pppams_review.save
    }
    render :text => "1"
  end

  def show
    @pppams_indicator = PppamsIndicator.find(params[:id])
  end

  def new
    @pppams_indicator = PppamsIndicator.new(:pppams_category_id => params[:pppams_category_id])
  end

  def create
    if params.include?(:is_global)
      base = PppamsIndicatorBaseRef.new
      base.question = params[:pppams_indicator][:question]
      base.pppams_category_base_ref_id = PppamsCategory.find(params[:pppams_indicator][:pppams_category_id]).pppams_category_base_ref_id
      base.save
      fail_ar = []
      for this_cat in PppamsCategoryBaseRef.find(base.pppams_category_base_ref_id).pppams_categories
        newind = PppamsIndicator.new(params[:pppams_indicator])
        newind.pppams_category_id = this_cat.id
        newind.pppams_indicator_base_ref_id = base.id
        newind.set_good_months
        fail_ar << newind.pppams_category.facility.facility unless newind.save
      end
      if fail_ar.length > 0
        flash[:notice] = 'PppamsIndicator creation failed for the following facilities: ' + fail_ar.join(', ')
        render :action => 'new'
      else
        flash[:notice] = 'PppamsIndicators were successfully created.'
        redirect_to :controller => 'pppams_categories', :action => 'show', :id => params[:pppams_indicator][:pppams_category_id]
      end
    else
      base = PppamsIndicatorBaseRef.new
      base.question = params[:pppams_indicator][:question]
      base.pppams_category_base_ref_id = PppamsCategory.find(params[:pppams_indicator][:pppams_category_id]).pppams_category_base_ref_id
      base.save
      @pppams_indicator = PppamsIndicator.new(params[:pppams_indicator])
      @pppams_indicator.set_good_months
      if @pppams_indicator.save
        flash[:notice] = 'PppamsIndicator was successfully created.'
        redirect_to :controller => 'pppams_categories', :action => 'show', :id => @pppams_indicator.pppams_category_id
      else
        render :action => 'new'
      end
    end
  end


  def set_frequency_options
    @frequency_options=OrderedHash.new()
    @frequency_options['1 - Annual'] =1
    @frequency_options['2 - Semi-annual'] = 2
    @frequency_options['4 - Quarterly'] = 4
    @frequency_options['12 - Monthly'] = 12
  end

  def edit
    @pppams_indicator = PppamsIndicator.find(params[:id])
  end

  def update
    @pppams_indicator = PppamsIndicator.find(params[:id])
    addme = [params[:pppams_indicator][:start_month].to_i]
    params[:pppams_indicator][:frequency].to_i.times { |f|
        if f > 0
            pushme = addme.last + f > 12 ?  addme.last + f  -12 : addme.last + f 
            addme.push(pushme)
        end
    }
    params[:pppams_indicator][:good_months] = ":" + addme.join(':') + ":"
    if @pppams_indicator.update_attributes(params[:pppams_indicator])
      flash[:notice] = 'PppamsIndicator was successfully updated.'
      redirect_to :action => 'show', :id => @pppams_indicator
    else
      render :action => 'edit'
    end
  end

  def destroy
    indicator = PppamsIndicator.find(params[:id])
    baseref = indicator.pppams_indicator_base_ref
    otherinds = baseref.pppams_indicators
    baseref.destroy if otherinds.length <= 1
    @thisIndicatorCat = indicator.pppams_category_id
    indicator.destroy
    redirect_to :action => 'show', :controller => 'pppams_categories', :id => @thisIndicatorCat
  end
  
  def update_all_good_months
      for this_ind in PppamsIndicator.find(:all)
      addme = [this_ind.start_month]
      fre = this_ind.frequency
      if fre > 0 
      addval = 12/fre
      fre.times { |f|
         if f > 0
         pushme = addme.last + addval > 12 ?  addme.last + addval  -12 : addme.last + addval 
         addme.push(pushme)
         end
      }
      end
      this_ind.good_months = ":" + addme.join(':') + ":"
      this_ind.save
    end
  end
  
  
end
