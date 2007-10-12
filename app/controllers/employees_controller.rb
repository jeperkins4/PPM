class EmployeesController < ApplicationController
  before_filter :authenticate
  layout 'administration'
  
  # GET /employees
  # GET /employees.xml
  def index
    
    @employee_filter =  session[:facility].employees.find(:all, :order =>['first_name, last_name'])
    
    @employee_pages, @employees = paginate_collection @employee_filter, :page => params[:page]
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @employees.to_xml }
    end
  end
  
  # GET /employees/1
  # GET /employees/1.xml
  def show
    
    @employee =  session[:facility].employees.find(params[:id])
    
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @employee.to_xml }
    end
  end
  
  # GET /employees/new
  def new
    @employee = Employee.new
  end
  
  # GET /employees/1;edit
  def edit
    @employee = Employee.find(params[:id])
  end
  
  # POST /employees
  # POST /employees.xml
  def create
    @employee = Employee.new(params[:employee])
    
    respond_to do |format|
      if @employee.save
        flash[:notice] = 'Employee was successfully created.'
        format.html { redirect_to employee_url(@employee) }
        format.xml  { head :created, :location => employee_url(@employee) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @employee.errors.to_xml }
      end
    end
  end
  
  # PUT /employees/1
  # PUT /employees/1.xml
  def update
    @employee = Employee.find(params[:id])
    
    respond_to do |format|
      if @employee.update_attributes(params[:employee])
        flash[:notice] = 'Employee was successfully updated.'
        format.html { redirect_to employee_url(@employee) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @employee.errors.to_xml }
      end
    end
  end
  
  # DELETE /employees/1
  # DELETE /employees/1.xml
  def destroy
   
       @employee = session[:facility].employees.find(params[:id])
       @employee.destroy
    
    respond_to do |format|
      format.html { redirect_to employees_url }
      format.xml  { head :ok }
    end
  end
end
