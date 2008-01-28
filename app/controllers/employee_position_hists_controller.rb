class EmployeePositionHistsController < ApplicationController

  before_filter :authenticate, :except => :reset_password
  layout 'administration'  
  
  # GET /employee_position_hists
  # GET /employee_position_hists.xml
  def index
    
    @facility_position_numbers = session[:facility].position_numbers.find(:all)    
    @employee_position_hists = EmployeePositionHist.find_all_by_position_number_id(@facility_position_numbers)
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @employee_position_hists.to_xml }
    end
  end

  # GET /employee_position_hists/1
  # GET /employee_position_hists/1.xml
  def show
    @employee_position_hist = EmployeePositionHist.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @employee_position_hist.to_xml }
    end
  end

  # GET /employee_position_hists/new
  def new
    @employee_position_hist = EmployeePositionHist.new
  end

  # GET /employee_position_hists/1;edit
  def edit
    @employee_position_hist = EmployeePositionHist.find(params[:id])
  end

  # POST /employee_position_hists
  # POST /employee_position_hists.xml
  def create
    @employee_position_hist = EmployeePositionHist.new(params[:employee_position_hist])

    respond_to do |format|
      if @employee_position_hist.save
        flash[:notice] = 'EmployeePositionHist was successfully created.'
        format.html { redirect_to employee_position_hist_url(@employee_position_hist) }
        format.xml  { head :created, :location => employee_position_hist_url(@employee_position_hist) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @employee_position_hist.errors.to_xml }
      end
    end
  end

  # PUT /employee_position_hists/1
  # PUT /employee_position_hists/1.xml
  def update
    @employee_position_hist = EmployeePositionHist.find(params[:id])

    respond_to do |format|
      if @employee_position_hist.update_attributes(params[:employee_position_hist])
        flash[:notice] = 'EmployeePositionHist was successfully updated.'
        format.html { redirect_to employee_position_hist_url(@employee_position_hist) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @employee_position_hist.errors.to_xml }
      end
    end
  end

  # DELETE /employee_position_hists/1
  # DELETE /employee_position_hists/1.xml
  def destroy
    @employee_position_hist = EmployeePositionHist.find(params[:id])
    @employee_position_hist.destroy

    respond_to do |format|
      format.html { redirect_to employee_position_hists_url }
      format.xml  { head :ok }
    end
  end
end
