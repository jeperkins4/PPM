class EmployeePositionsController < ApplicationController
  
  layout 'administration'
  
  
  # GET /employee_positions
  # GET /employee_positions.xml
  def index
    if session[:access_level] == 'Administrator'
      @employee_positions = EmployeePosition.find(:all)
    else
      @position_facility = session[:facility].position_numbers
      @employee_positions = []
      @position_facility.each do |pf|
        @employee_positions += EmployeePosition.find(:all, :conditions => ['position_number_id = ?', pf.id])
      end      
    end
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @employee_positions.to_xml }
    end
  end
  
  # GET /employee_positions/1
  # GET /employee_positions/1.xml
  def show
    if session[:access_level] == 'Administrator'
      @employee_position = EmployeePosition.find(params[:id])
    else
      @position_facility = session[:facility].position_numbers
      @employee_positions = []
      @position_facility.each do |pf|
        if EmployeePosition.find(params[:id]).position_number_id == pf.id then
          @employee_position = EmployeePosition.find(params[:id])
        end
      end  
    end    
    
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @employee_position.to_xml }
    end
  end
  
  # GET /employee_positions/new
  def new
    @employee_position = EmployeePosition.new
  end
  
  # GET /employee_positions/1;edit
  def edit
    @employee_position = EmployeePosition.find(params[:id])
  end
  
  # POST /employee_positions
  # POST /employee_positions.xml
  def create
    
    @employee_position = EmployeePosition.new(params[:employee_position])
    
    respond_to do |format|
      if @employee_position.save
        flash[:notice] = 'EmployeePosition was successfully created.'
        format.html { redirect_to employee_position_url(@employee_position) }
        format.xml  { head :created, :location => employee_position_url(@employee_position) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @employee_position.errors.to_xml }
      end
    end
  end
  
  # PUT /employee_positions/1
  # PUT /employee_positions/1.xml
  def update
    @employee_position = EmployeePosition.find(params[:id])
    
    respond_to do |format|
      if @employee_position.update_attributes(params[:employee_position])
        flash[:notice] = 'EmployeePosition was successfully updated.'
        format.html { redirect_to employee_position_url(@employee_position) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @employee_position.errors.to_xml }
      end
    end
  end
  
  # DELETE /employee_positions/1
  # DELETE /employee_positions/1.xml
  def destroy
    if session[:access_level] == 'Administrator'
      @employee_position = EmployeePosition.find(params[:id])
    else
      @position_facility = session[:facility].position_numbers
      @employee_positions = []
      @position_facility.each do |pf|
        if EmployeePosition.find(params[:id]).position_number_id == pf.id then
          @employee_position = EmployeePosition.find(params[:id])
        end
      end
    end
    @employee_position.destroy
    
    respond_to do |format|
      format.html { redirect_to employee_positions_url }
      format.xml  { head :ok }
    end
  end
  
  def set_facility
    if request.post?     
      
      if params[:facility][:facility_id] != ""
        session[:facility] = Facility.find(params[:facility][:facility_id])
      end
      
      session[:position] = nil
      
      redirect_to new_employee_position_path      
      
    end
  end
  
  def set_facility2
    if request.post?
      session[:position] = Position.find(params[:facility][:position_id])
      redirect_to new_employee_position_path   
    end      
  end
  
end
