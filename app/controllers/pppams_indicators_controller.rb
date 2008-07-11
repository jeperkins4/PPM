class PppamsIndicatorsController < ApplicationController
  before_filter :authenticate
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
    @pppams_indicator_pages, @pppams_indicators = paginate :pppams_indicators, :per_page => 100
  end

  def pure_list
    @pppams_indicator_pages, @pppams_indicators = paginate :pppams_indicators, :per_page => 100
  end
  
  def _to_do 
    render :partial => 'to_do', :locals => {:time => Time.parse(params[:time]) }
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
    @frequency_options=OrderedHash.new()
    @frequency_options['1 - Annual'] =1
    @frequency_options['2 - Semi-annual'] = 2
    @frequency_options['4 - Quarterly'] = 4
    @frequency_options['12 - Monthly'] = 12
    @pppams_indicator = PppamsIndicator.find(params[:id])
  end

  def update
    @frequency_options=OrderedHash.new()
    @frequency_options['1 - Annual'] =1
    @frequency_options['2 - Semi-annual'] = 2
    @frequency_options['4 - Quarterly'] = 4
    @frequency_options['12 - Monthly'] = 12
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
    @thisIndicatorCat = PppamsIndicator.find(params[:id]).pppams_category_id
    PppamsIndicator.find(params[:id]).destroy
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
