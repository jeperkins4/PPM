class PppamsIndicatorsController < ApplicationController
  before_filter :authenticate
  before_filter :require_facility, :except => [:show, :edit, :update]

  layout 'administration'

 require 'rubygems'
 require 'orderedhash.rb'

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => {:controller => 'incidents'}

  def index
    list
    render :action => 'list'
  end

  def list
    @pppams_indicators = PppamsIndicator.paginate :page => params[:page]
    session[:indicator_list_mode] = 'list'
  end

  #Lists Review data
  def editable_list
    @pppams_indicators = PppamsIndicator.paginate :page => params[:page]
    session[:indicator_list_mode] = 'editable_list'
    render :action => 'list'
  end

  # used to list "Indicator Data"
  def _to_do
    @time = session[:working_date] = Time.parse(params[:time])
    @currents = PppamsIndicator.find_current(@time, session[:facility])

    render :partial => 'to_do', :locals => {:time => @time, :currents => @currents }
  end

  # used to list "Review Data"
  def _editable_to_do
    render :partial => 'editable_to_do', :locals => {:time => Time.parse(params[:time]) }
  end

  # Update several reviews with new status and notes
  def bulk_update
    params[:pppams_review_selector].each { |id|
      @pppams_review = PppamsReview.find(id)
      @pppams_review.status = params[:pppams_review_new_status]
      @pppams_review.notes = @pppams_review.notes.nil? ? 
        params[:pppams_review_bulk_note] : 
        @pppams_review.notes + "\r\n" + params[:pppams_review_bulk_note]
      @pppams_review.save
    }
    render :text => "1"
  end

  def show
    @pppams_indicator = PppamsIndicator.find(params[:id])
  end

  def edit
    @pppams_indicator = PppamsIndicator.find(params[:id])
  end

  def update
    @pppams_indicator = PppamsIndicator.find(params[:id])
    @pppams_indicator.update_good_months(params[:pppams_indicator][:start_month],
                                         params[:pppams_indicator][:frequency])

    if @pppams_indicator.update_attributes(params[:pppams_indicator])
      flash[:notice] = 'PppamsIndicator was successfully updated.'
      redirect_to :action => 'show', :id => @pppams_indicator
    else
      render :action => 'edit'
    end
  end

end
