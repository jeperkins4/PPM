class EmployeePositionsController < ApplicationController
  before_filter :authenticate
  layout 'administration'
  
  
  # GET /employee_positions
  # GET /employee_positions.xml
  def index
    @position_facility = session[:facility].position_numbers
    @employee_positions = []
    @position_facility.each do |pf|
      @employee_positions += EmployeePosition.find(:all, :conditions => ['position_number_id = ?', pf.id])
      
    end
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @employee_positions.to_xml }
    end
  end
  
  # GET /employee_positions/1
  # GET /employee_positions/1.xml
  def show
    @position_facility = session[:facility].position_numbers
    @employee_positions = []
    @position_facility.each do |pf|
      if EmployeePosition.find(params[:id]).position_number_id == pf.id then
        @employee_position = EmployeePosition.find(params[:id])
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
    session[:position] = @employee_position.position_number.position
    session[:facility] = session[:position].facility
    session[:position_number] = @employee_position.position_number
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
      if params[:employee_position]['end_date(1i)'] == "" ||
        params[:employee_position]['end_date(2i)'] == "" || 
        params[:employee_position]['end_date(3i)'] == "" then
        
        params[:employee_position]['end_date(1i)'] = ""
        params[:employee_position]['end_date(2i)'] = ""
        params[:employee_position]['end_date(3i)'] = ""
        
        if @employee_position.update_attributes(params[:employee_position])
          
          flash[:notice] = 'EmployeePosition was successfully updated.'
          format.html { redirect_to employee_position_url(@employee_position) }
          format.xml  { head :ok }
          
        else
          
          format.html { render :action => "edit" }
          format.xml  { render :xml => @employee_position.errors.to_xml }
          
        end
        
      else
        @start_date = Date.new(params[:employee_position].delete('start_date(1i)').to_i, params[:employee_position].delete('start_date(2i)').to_i, (params[:employee_position].delete('start_date(3i)')||1).to_i) if params[:employee_position]['start_date(3i)']
        @end_date = Date.new(params[:employee_position].delete('end_date(1i)').to_i, params[:employee_position].delete('end_date(2i)').to_i, (params[:employee_position].delete('end_date(3i)')||1).to_i) if params[:employee_position]['end_date(3i)'] 
        
        if @end_date > @start_date
          params[:employee_position][:create_date] = Time.now
          params[:employee_position][:salary] = session[:position][:salary]
          params[:employee_position][:start_date] = @start_date
          params[:employee_position][:end_date] = @end_date          
          @employee_position_history = EmployeePositionHist.new(params[:employee_position])
          @employee_position_history.save
          @employee_position.destroy
          flash[:notice] = "End Date Added - Row has been archived"
          format.html {redirect_to employee_positions_path}
        else
          flash[:notice] = "End Date must be greater than the Start Date"
          format.html { render :action => "edit" }
        end
      end
    end
  end
  
  # DELETE /employee_positions/1
  # DELETE /employee_positions/1.xml
  def destroy
    @position_facility = session[:facility].position_numbers
    @employee_positions = []
    @position_facility.each do |pf|
      if EmployeePosition.find(params[:id]).position_number_id == pf.id then
        @employee_position = EmployeePosition.find(params[:id])
      end
    end
    @employee_position.destroy
    
    respond_to do |format|
      format.html { redirect_to employee_positions_url }
      format.xml  { head :ok }
    end
  end
  
  # def set_facility
  #  if request.post?     
  #   
  #   session[:facility] = Facility.find(params[:facility][:facility_id])
  #   end
  
  #   session[:position] = nil
  #   
  #   redirect_to new_employee_position_path      
  
  #  end
  #end
  
  def set_facility2
    if request.post?
      session[:position] = Position.find(params[:facility][:position_id])
      redirect_to new_employee_position_path   
    end      
  end
  
end
