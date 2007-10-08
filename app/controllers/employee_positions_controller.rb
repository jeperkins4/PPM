class EmployeePositionsController < ApplicationController
  before_filter :authenticate
  layout 'administration'
  
  
  # GET /employee_positions
  # GET /employee_positions.xml
  def index
    flash[:notice] = nil
    
    @position_numbers = []
    @employee_position_all = []
    
    @positions = session[:facility].positions.find(:all,:order=>'title ASC')
    
    @positions.each do |p|
      @position_numbers += PositionNumber.find(:all,:conditions=>['position_id = ?', p.id])
    end
    
    @position_numbers.each do |pf|
      @employee_position_all += EmployeePosition.find(:all,:conditions => ['position_number_id = ?', pf.id])
    end
    
    @employee_position_pages, @employee_positions = paginate_collection @employee_position_all, :page => params[:page]
    
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
    @assigned_numbers = EmployeePosition.find(:all, :select=>'position_number_id as id')
    @assigned_employees = EmployeePosition.find(:all, :select=>'employee_id as id')
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
    if lateral_move then      
      redirect_to :back
    else      
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
  
  def lateral_move     
    
    @new_position_number = Position.find(:first, :select=>'p.id as id',:from=>'position_numbers pn, positions p',
    :conditions=>['pn.id = ? and pn.position_id = p.id', params[:employee_position][:position_number_id]])    
    
    @old_position_number = EmployeePositionHist.find(:first, :conditions=>['employee_id = ? AND end_date = (SELECT MAX(end_date) FROM employee_position_hists where employee_id = ?)',params[:employee_position][:employee_id], params[:employee_position][:employee_id]])
    
    if @new_position_number != nil and @old_position_number != nil then
      if @new_position_number.id == @old_position_number.position_number.position_id
        flash[:notice] = "You are trying to assign " + @old_position_number.employee.first_name + 
                       " to a position number that holds the same Position Title as the employees previous position number:" + @old_position_number.position_number.position_num + "."
        flash[:notice] =  flash[:notice] + " This is an illegal move and is not allowed.  If you feel you have received this message in error, please contact your administrator."
        return true
      end
    end
  end
  
  
  def set_facility2
    if request.post?
      
      session[:position] = Position.find(params[:facility][:position_id])
      redirect_to new_employee_position_path   
    end
  end
  
end
