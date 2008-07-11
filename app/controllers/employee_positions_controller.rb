class EmployeePositionsController < ApplicationController
  before_filter :authenticate
  layout 'administration'
  
  
  # GET /employee_positions
  # GET /employee_positions.xml
  def index
    
    @employee_position_all = EmployeePosition.available_positions(session[:facility][:id])
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
    @assigned_numbers = EmployeePosition.find(:all, :select=>'position_number_id as id' )
    @assigned_employees = EmployeePosition.find(:all, :select=>'employee_id as id')
    @employee_position = EmployeePosition.new
  end
  
  # GET /employee_positions/1;edit
  def edit
    @assigned_numbers = EmployeePosition.find(:all, :select=>'position_number_id as id', :conditions=>['id <> ?', params[:id]])
    @assigned_employees = EmployeePosition.find(:all, :select=>'employee_id as id', :conditions=>['id <> ?', params[:id]])
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
          format.xml  { render :xml => @employee_position.errors.to_xml}
        end
      end
    end
  end
  
  # PUT /employee_positions/1
  # PUT /employee_positions/1.xml
  def update
    @employee_position = EmployeePosition.find(params[:id])
    @assigned_numbers = EmployeePosition.find(:all, :select=>'position_number_id as id', :conditions=>['id <> ?', params[:id]])
    @assigned_employees = EmployeePosition.find(:all, :select=>'employee_id as id', :conditions=>['id <> ?', params[:id]])
    session[:position] = @employee_position.position_number.position
    session[:facility] = session[:position].facility
    session[:position_number] = @employee_position.position_number
    
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
          
          format.html {render :action => "edit"}
          format.xml  {render :xml => @employee_position.errors.to_xml}
          
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
          if @employee_position_history.save then         
            @employee_position.destroy
            flash[:notice] = "End Date Added - Row has been archived"
            format.html { redirect_to :controller => 'employees', :action => 'show', :id => params[:employee_position][:employee_id] }
          else
            flash[:notice] = "Saving Data Failed - #{@employee_position_history.errors.to_xml}"
            format.html { render :action => "edit" }
          end
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
  
  
  def set_position_new
    
    if request.post?
      
      session[:position] = Position.find(params[:facility][:position_id])
      redirect_to new_employee_position_path   
    end
  end 
  
  def set_filter
    session[:search_dropdown] = params[:id][:filter_drop] rescue ''
    session[:search_text] = params[:employee_position][:filter_text] rescue ''
    if session[:search_dropdown].to_s != nil and session[:search_dropdown] != "" then
      @search = 'ep.employee_id = e.id and ep.position_number_id = pn.id and pn.position_id = p.id and p.facility_id = f.id and ' +
        session[:search_dropdown] + " like " + '"' + session[:search_text] + "%" + '"' + ' and f.id = ?'
      
      @employee_positions = EmployeePosition.find(:all, :select => 'ep.id as id, ep.position_number_id, ep.employee_id, ep.start_date,
                                                 ep.end_date', :order=>'p.title',
        :from=>'employees e, employee_positions ep, position_numbers pn, positions p, facilities f',
        :conditions=>["#{@search}", session[:facility][:id]])
      
      #    @employee_position_pages, @employee_positions = paginate_collection @employee_position_all, :page => params[:page]
      render :action => 'index'
    else
      redirect_to :action => 'index'
    end   
  end  
  
end
