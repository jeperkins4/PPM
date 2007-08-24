class InmateCountsController < ApplicationController
  
  before_filter :authenticate
  layout 'administration'
  
  def index
    if session[:access_level] == 'Administrator'
      @inmate_counts = InmateCount.find(:all)
    else
      @inmate_counts = session[:facility].inmate_counts.find(:all)
    end
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @inmate_counts.to_xml }
    end
  end
  
  # GET /inmate_counts/1
  # GET /inmate_counts/1.xml
  def show
    @inmate_count = InmateCount.find(params[:id])
    
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @inmate_count.to_xml }
    end
  end
  
  # GET /inmate_counts/new
  def new
    if session[:access_level] == 'Administrator'
      @inmate_count = InmateCount.new
    else
      @custody_types = session[:facility].custody_types.find(:all)
      @inmate_count = session[:facility].inmate_counts.new
    end
  end
  
  # GET /inmate_counts/1;edit
  def edit
    @inmate_count = InmateCount.find(params[:id])
  end
  
  # POST /inmate_counts
  # POST /inmate_counts.xml
  def create
    if session[:access_level] == 'Administrator'
      @inmate_count = InmateCount.new(params[:inmate_count])
      
      respond_to do |format|
        if @inmate_count.save
          flash[:notice] = 'InmateCount was successfully created.'
          format.html { redirect_to inmate_count_url(@inmate_count) }
          format.xml  { head :created, :location => inmate_count_url(@inmate_count) }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @inmate_count.errors.to_xml }
        end
      end
    else
      @custody_types = session[:facility].custody_types.find(:all)
      params[:custody_types].each_pair do |custody_type, count|
        
        @inmate_count = InmateCount.create(:facility_id     => session[:facility].id,
                                           :inmate_count    => count,
                                           :custody_type_id => custody_type,
                                           :date_collected  => Time.now()
        )  
      end
      flash[:notice] = 'Inmate count(s) were successfully recorded.'
      redirect_to inmate_counts_path
    end
  end
  
  # PUT /inmate_counts/1
  # PUT /inmate_counts/1.xml
  def update
    @inmate_count = InmateCount.find(params[:id])
    
    respond_to do |format|
      if @inmate_count.update_attributes(params[:inmate_count])
        flash[:notice] = 'InmateCount was successfully updated.'
        format.html { redirect_to inmate_count_url(@inmate_count) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @inmate_count.errors.to_xml }
      end
    end
  end
  
  # DELETE /inmate_counts/1
  # DELETE /inmate_counts/1.xml
  def destroy
    @inmate_count = InmateCount.find(params[:id])
    @inmate_count.destroy
    
    respond_to do |format|
      format.html { redirect_to inmate_counts_url }
      format.xml  { head :ok }
    end
  end
end
