class PppamsIndicatorsController < ApplicationController
<<<<<<< HEAD
  # GET /pppams_indicators
  # GET /pppams_indicators.json
  def index
    @pppams_indicators = PppamsIndicator.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pppams_indicators }
    end
  end

  # GET /pppams_indicators/1
  # GET /pppams_indicators/1.json
  def show
    @pppams_indicator = PppamsIndicator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pppams_indicator }
    end
  end

  # GET /pppams_indicators/new
  # GET /pppams_indicators/new.json
  def new
    @pppams_indicator = PppamsIndicator.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pppams_indicator }
    end
  end

  # GET /pppams_indicators/1/edit
=======
  before_filter :authenticate
  before_filter :require_facility, :except => [:show, :edit, :update, :new]

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

  def show
    @pppams_indicator = PppamsIndicator.find(params[:id])
  end

>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
  def edit
    @pppams_indicator = PppamsIndicator.find(params[:id])
  end

<<<<<<< HEAD
  # POST /pppams_indicators
  # POST /pppams_indicators.json
  def create
    @pppams_indicator = PppamsIndicator.new(params[:pppams_indicator])

    respond_to do |format|
      if @pppams_indicator.save
        format.html { redirect_to @pppams_indicator, notice: 'Pppams indicator was successfully created.' }
        format.json { render json: @pppams_indicator, status: :created, location: @pppams_indicator }
      else
        format.html { render action: "new" }
        format.json { render json: @pppams_indicator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pppams_indicators/1
  # PUT /pppams_indicators/1.json
  def update
    @pppams_indicator = PppamsIndicator.find(params[:id])

    respond_to do |format|
      if @pppams_indicator.update_attributes(params[:pppams_indicator])
        format.html { redirect_to @pppams_indicator, notice: 'Pppams indicator was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pppams_indicator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pppams_indicators/1
  # DELETE /pppams_indicators/1.json
  def destroy
    @pppams_indicator = PppamsIndicator.find(params[:id])
    @pppams_indicator.destroy

    respond_to do |format|
      format.html { redirect_to pppams_indicators_url }
      format.json { head :no_content }
    end
  end
=======
  def new
    @pppams_indicator = PppamsIndicator.new(:pppams_indicator_base_ref => PppamsIndicatorBaseRef.find(params[:pppams_indicator_base_ref_id]),
                                            :facility => Facility.find(params[:facility_id]))
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
      pppams_review = PppamsReview.find(id)
      pppams_review.status = params[:pppams_review_new_status]
      pppams_review.notes = pppams_review.notes.nil? ? 
        params[:pppams_review_bulk_note] : 
        pppams_review.notes + "\r\n" + params[:pppams_review_bulk_note]
      pppams_review.save
    }
    render :text => "1"
  end


>>>>>>> 7436653363ecf064fdcfcd2b30df919b5144a2b8
end
